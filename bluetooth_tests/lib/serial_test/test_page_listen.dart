import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothReceiver extends StatefulWidget {
  @override
  _BluetoothReceiverState createState() => _BluetoothReceiverState();
}

class _BluetoothReceiverState extends State<BluetoothReceiver> {
  BluetoothConnection? _connection;
  String _message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Receiver'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Mensagem Recebida:',
              style: TextStyle(fontSize: 24),
            ),
          ),
          Center(
            child: Text(
              _message,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  @override
  void dispose() {
    _stopListening();
    super.dispose();
  }

  Future<void> _startListening() async {
    // Obter uma instância do Bluetooth
    final FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;

    // Verificar se o Bluetooth está disponível
    bool? isAvailable = await bluetooth.isAvailable;
    if (!isAvailable!) {
      print('Bluetooth não está disponível');
      return;
    }

    // Verificar se o Bluetooth está ligado
    bool? isEnabled = await bluetooth.isEnabled;
    if (!isEnabled!) {
      print('Bluetooth não está ligado');
      return;
    }

    // Obter a lista de dispositivos pareados
    List<BluetoothDevice> devices = await bluetooth.getBondedDevices();

    // Conectar-se a um dispositivo específico
    for (BluetoothDevice device in devices) {
      if (device.name == 'NOME_DO_DISPOSITIVO') {
        try {
          _connection = await BluetoothConnection.toAddress(device.address);
          print('Conectado com ${device.name}');
          _listenForData();
          break;
        } catch (e) {
          print('Erro ao conectar: $e');
        }
      }
    }
  }

  void _listenForData() async {
    _connection!.input!.listen((data) {
      setState(() {
        _message += utf8.decode(data);
      });
    });
  }

  void _stopListening() {
    _connection?.dispose();
  }
}
