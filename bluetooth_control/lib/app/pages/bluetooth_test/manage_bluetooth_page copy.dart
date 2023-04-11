// import 'package:flutter/material.dart';
// import 'package:flutter_blue/flutter_blue.dart';

// class ManageBluetoothPage extends StatefulWidget {
//   const ManageBluetoothPage({Key? key}) : super(key: key);

//   @override
//   _ManageBluetoothPageState createState() => _ManageBluetoothPageState();
// }

// class _ManageBluetoothPageState extends State<ManageBluetoothPage> {
//   late FlutterBlue flutterBlue;
//   bool _isScanning = false;
//   List<BluetoothDevice> _devicesList = [];

//   @override
//   void initState() {
//     super.initState();
//     flutterBlue = FlutterBlue.instance;
//   }

//   Future<void> _scanDevices() async {
//     setState(() {
//       _isScanning = true;
//       _devicesList = [];
//     });
// // Escaneia dispositivos Bluetooth
//     flutterBlue.startScan(timeout: const Duration(seconds: 5));

// // Adiciona os dispositivos encontrados na lista
//     flutterBlue.scanResults.listen((results) {
//       for (ScanResult r in results) {
//         if (!_devicesList.contains(r.device)) {
//           setState(() {
//             _devicesList.add(r.device);
//           });
//         }
//       }
//     });

//     flutterBlue.stopScan();
//     setState(() {
//       _isScanning = false;
//     });
//   }

//   Future<void> _connectToDevice(BluetoothDevice device) async {
// // Conecta ao dispositivo escolhido
//     try {
//       await device.connect();
// // Implemente aqui o código para comunicar com o dispositivo conectado
//     } catch (e) {
//       print('Erro ao conectar ao dispositivo: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Controle de Motores'),
//       ),
//       body: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                 onPressed: _isScanning ? null : _scanDevices,
//                 child: const Text('Procurar dispositivos'),
//               ),
//             ],
//           ),
//           Expanded(
//             child: _isScanning
//                 ? const Center(child: CircularProgressIndicator())
//                 : _devicesList.isEmpty
//                     ? const Center(
//                         child: Text(
//                             'Nenhum dispositivo encontrado durante a busca'))
//                     : ListView.builder(
//                         itemCount: _devicesList.length,
//                         itemBuilder: (context, index) {
//                           final device = _devicesList[index];
//                           return ListTile(
//                             title: Text(device.name),
//                             subtitle: Text(device.id.toString()),
//                             onTap: () => _connectToDevice(device),
//                           );
//                         },
//                       ),
//           ),
//         ],
//       ),
//     );
//   }
// }
