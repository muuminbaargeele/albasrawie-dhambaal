import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../constants/constants.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  late io.Socket _socket;

  void connect() {
    // Normalize base URL (remove any trailing slash) to avoid building something like https://host:0/
    final base = Constants.devBaseUrl.replaceFirst(RegExp(r"/*$"), "");

    // Build Socket.IO options explicitly to avoid the :0 port issue and ensure correct path
    final options = io.OptionBuilder()
        .setTransports(['websocket']) // force WS
        .setPath('/socket.io')        // default path, set explicitly
        .enableForceNew()             // create a fresh manager
        .enableReconnection()         // auto-reconnect
        .setReconnectionAttempts(5)
        .setReconnectionDelay(1000)
        .setTimeout(10000)
        // Optional: some proxies care about Origin; set it to your host if you use HTTPS domain
        .setExtraHeaders({'Origin': base})
        .build();

    if (kDebugMode) {
      print('🔗 Attempting Socket.IO connect to: $base (path=/socket.io)');
    }

    _socket = io.io(base, options);

    _socket.onConnect((_) {
      if (kDebugMode) {
        print('✅ Socket.IO connected to $base');
      }
    });

    _socket.onDisconnect((_) {
      if (kDebugMode) {
        print('🔌 Socket.IO disconnected');
      }
    });

    // Add richer diagnostics
    _socket.onError((error) {
      if (kDebugMode) {
        print('❌ Socket.IO error: $error');
      }
    });

    _socket.on('connect_error', (data) {
      if (kDebugMode) {
        print('❌ connect_error: $data');
      }
    });

    _socket.on('reconnect_attempt', (_) {
      if (kDebugMode) {
        print('↻ Reconnect attempt...');
      }
    });

    _socket.on('reconnect_failed', (_) {
      if (kDebugMode) {
        print('❌ Reconnect failed');
      }
    });
  }

  void emit(String event, dynamic data) {
    _socket.emit(event, data);
    if (kDebugMode) {
      print("📤 Emitted [$event]: $data");
    }
  }

  void on(String event, Function(dynamic) callback) {
    _socket.on(event, callback);
  }

  void off(String event) {
    _socket.off(event);
  }

  void disconnect() {
    _socket.disconnect();
    if (kDebugMode) {
      print("🔌 Socket.IO manually disconnected");
    }
  }

  bool get isConnected => _socket.connected;
}