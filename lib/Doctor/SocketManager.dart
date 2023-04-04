import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketManager {
  static io.Socket? _socket;

  static io.Socket getSocket() {
    if (_socket == null) {
      _socket = io.io('https://99c6-103-248-123-94.in.ngrok.io', <String, dynamic>{
        'transports': ['websocket'],
        'forceNew':true
      });
    }
    return _socket!;
  }

  static void dispose() {
    _socket?.dispose();
    _socket = null;
  }
}
