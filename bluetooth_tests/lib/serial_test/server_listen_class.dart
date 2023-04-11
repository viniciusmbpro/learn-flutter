import 'dart:convert';
import 'dart:io';

class BluetoothServer {
  ServerSocket? serverSocket;

  void startServer() async {
    serverSocket = await ServerSocket.bind('localhost', 12345);
    print('Servidor iniciado');

    serverSocket?.listen((socket) {
      socket.listen((data) {
        String message = utf8.decode(data);
        print('Mensagem recebida: $message');
      });
    });
  }

  void stopServer() {
    serverSocket?.close();
    print('Servidor parado');
  }
}
