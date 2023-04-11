import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  // Criando instância do Bluetooth
  BluetoothConnection? connection;

  // Lista de dispositivos pareados
  List<BluetoothDevice> pairedDevices = [];

  // Controller do campo de texto
  final TextEditingController textEditingController = TextEditingController();

  // String para guardar a mensagem
  String message = '';

  // Método para descobrir dispositivos pareados
  void discoverDevices() async {
    pairedDevices = await FlutterBluetoothSerial.instance.getBondedDevices();

    setState(() {});
  }

// Método para estabelecer conexão com o dispositivo selecionado
  void connectToDevice(BluetoothDevice device) async {
    BluetoothConnection? _connection;

    try {
      // Abra uma conexão com o dispositivo selecionado
      _connection = await BluetoothConnection.toAddress(device.address);
      print('Conectado com ${device.name}');

      setState(() {
        connection = _connection;
      });

      // Escute por mensagens recebidas
      connection!.input!.listen((data) {
        setState(() {
          message += utf8.decode(data);
        });
      });
    } catch (e) {
      print('Erro ao conectar: $e');
    }
  }

  // Método para enviar mensagem
  void sendMessage() {
    if (textEditingController.text.isNotEmpty) {
      connection!.output
          .add(Uint8List.fromList(utf8.encode(textEditingController.text)));
      setState(() {
        textEditingController.text = '';
      });
    }
  }

  // Método para desconectar do dispositivo
  void disconnect() async {
    await connection?.close();
    setState(() {
      connection = null;
      message = '';
    });
  }

  @override
  void initState() {
    super.initState();

    // Descobrir dispositivos pareados ao iniciar o widget
    discoverDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Chat'),
      ),
      body: connection == null
          ? Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Dispositivos pareados',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: pairedDevices.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(pairedDevices[index].name.toString()),
                        subtitle: Text(pairedDevices[index].address),
                        onTap: () {
                          // Conectar ao dispositivo selecionado
                          connectToDevice(pairedDevices[index]);
                        },
                      );
                    },
                  ),
                ),
              ],
            )
          : Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Conectado com ${connection!.output}',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      message,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: textEditingController,
                          decoration: const InputDecoration(
                            hintText: 'Digite uma mensagem...',
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: sendMessage,
                      icon: const Icon(Icons.send),
                      color: Colors.blue,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: disconnect,
                  child: const Text('Desconectar'),
                ),
              ],
            ),
    );
  }
}
