import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../constants/constants.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  late IO.Socket _socket;

  void connect() {
    _socket = IO.io(Constants.devBaseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    _socket.onConnect((_) {
      print('✅ Socket.IO connected to ${Constants.devBaseUrl}');
    });

    _socket.onDisconnect((_) {
      print('🔌 Socket.IO disconnected');
    });

    _socket.onError((error) {
      print('❌ Socket.IO error: $error');
    });
  }

  void emit(String event, dynamic data) {
    _socket.emit(event, data);
    print("📤 Emitted [$event]: $data");
  }

  void on(String event, Function(dynamic) callback) {
    _socket.on(event, callback);
  }

  void off(String event) {
    _socket.off(event);
  }

  void disconnect() {
    _socket.disconnect();
    print("🔌 Socket.IO manually disconnected");
  }

  bool get isConnected => _socket.connected;
}