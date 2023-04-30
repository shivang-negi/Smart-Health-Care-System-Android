import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketManager {
  static io.Socket? _socket;

  static io.Socket getSocket() {
    if (_socket == null) {
      _socket = io.io('https://87b9-103-248-123-90.ngrok-free.app', <String, dynamic>{
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
