import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class ManageBluetoothPage extends StatefulWidget {
  @override
  _ManageBluetoothPageState createState() => _ManageBluetoothPageState();
}

class _ManageBluetoothPageState extends State<ManageBluetoothPage> {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  Stream<List<ScanResult>> scanResultsStream = Stream.empty();

  Future<void> requestPermissions(BuildContext context) async {
    Map<Permission, PermissionStatus> results = await [
      Permission.location,
      Permission.bluetooth,
      Permission.bluetoothAdvertise,
      Permission.bluetoothScan,
    ].request();

    if (results[Permission.location] != PermissionStatus.granted ||
        results[Permission.bluetooth] != PermissionStatus.granted ||
        results[Permission.bluetoothAdvertise] != PermissionStatus.granted ||
        results[Permission.bluetoothScan] != PermissionStatus.granted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Permissões necessárias não foram concedidas.'),
      ));
    }
  }

  void startScan() async {
    if (await Permission.bluetoothScan.request().isGranted) {
      flutterBlue.scan().listen((ScanResult scanResult) {
        setState(() {
          scanResultsStream = Stream.value([scanResult]);
        });
      });
    } else {
      print('Bluetooth scan permission denied');
    }
  }

  void stopScan() {
    flutterBlue.stopScan();
  }

  @override
  void initState() {
    super.initState();
    startScan();
  }

  @override
  void dispose() {
    stopScan();
    super.dispose();
  }

  Widget _buildListViewOfDevices(
      BuildContext context, List<ScanResult> devices) {
    requestPermissions(context);
    return ListView.builder(
      itemCount: devices.length,
      itemBuilder: (BuildContext context, int index) {
        ScanResult device = devices[index];
        return ListTile(
          title: Text(device.device.name.isNotEmpty
              ? device.device.name
              : "Unknown device"),
          subtitle: Text(device.device.id.toString()),
          trailing: Text('${device.rssi} dBm'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Devices'),
      ),
      body: StreamBuilder<List<ScanResult>>(
        stream: scanResultsStream,
        initialData: [],
        builder:
            (BuildContext context, AsyncSnapshot<List<ScanResult>> snapshot) {
          return _buildListViewOfDevices(context, snapshot.data ?? []);
        },
      ),
    );
  }
}
