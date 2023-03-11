import 'dart:convert';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Uint8List, rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';


class ChatUI extends StatefulWidget {
  final String name,number;
  const ChatUI({Key ?key,
    required this.name,
    required this.number
  }): super(key:key);

  @override
  State<ChatUI> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatUI> {
  List<types.Message> _messages = [];
  var _user;
  late IO.Socket _socket;
  final String hosturl = "https://c375-103-248-123-92.in.ngrok.io";

  receiveText(data) {
    print(data);
    var _sender  = types.User(id: data['sender']);
    if(_sender==_user) return;
    final textMessage = types.TextMessage(
      author: _sender,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: data['message'],
    );
    _addMessage(textMessage);
  }

  // Uint8List dataFromBase64String(String base64String) {
  //   return base64Decode(base64String);
  // }
  //
  // receiveImage(data) async {
  //   print(data['message'].length);
  //   var _sender  = types.User(id: data['sender']);
  //   final bytes = dataFromBase64String(data['message']);
  //   final image = await decodeImageFromList(bytes);
  //
  //   final message = types.ImageMessage(
  //     author: _sender,
  //     createdAt: DateTime.now().millisecondsSinceEpoch,
  //     height: image.height.toDouble(),
  //     id: const Uuid().v4(),
  //     name: 'abc',
  //     size: bytes.length,
  //     uri: '/',
  //     width: image.width.toDouble(),
  //   );
  //   _addMessage(message);
  // }

  _connect() {
    _socket.onConnect((data) => print("Connection established"));
    _socket.onConnectError((data) => print('Error: $data'));
    _socket.onDisconnect((data) => print("Disconnected"));
    _socket.on('messageText',(data)=> receiveText(data));
    // _socket.on('messageImage',(data)=> receiveImage(data));
  }

  @override
  void initState() {
    _user  = types.User(id: widget.number);
    _socket = IO.io(hosturl,IO.OptionBuilder().
    setTransports(['websocket']).
    setQuery({'username': widget.number}).
    build());
    _connect();
    super.initState();
    _loadMessages();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: const Color(0xFF1E1285),
      automaticallyImplyLeading: false,
      leading: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: const Color(0xFF1E1285),
            fixedSize: const Size(50,50)
        ),
        child: const Icon(Icons.arrow_back_rounded,
          color: Colors.white,
          size: 30,),
      ),
      title: const Text(
        'Chat',
        style: TextStyle(
            fontFamily: 'Lexend',
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600
        ),
      ),
      actions: const [],
      centerTitle: false,
      elevation: 0,
    ),
    body: Chat(
      messages: _messages,
      onAttachmentPressed: _handleAttachmentPressed,
      onMessageTap: _handleMessageTap,
      onPreviewDataFetched: _handlePreviewDataFetched,
      onSendPressed: _handleSendPressed,
      user: _user,
    ),
  );

  void _addMessage(types.Message message) {
    if (mounted) {
      setState(() {
        _messages.insert(0, message);
      });
    }
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      _addMessage(message);
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final imageString = base64Encode(bytes);

      String str = result.path;
      print(str);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );
      _socket.emit('messageImage',{
        'message': imageString,
        'sender': _user
      });
      _addMessage(message);
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
          _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
          (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
          _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
          (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(types.TextMessage message, types.PreviewData previewData,
      ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    _socket.emit('messageText',{
      'message': message.text,
      'sender': _user
    });
    _addMessage(textMessage);
  }

  void _loadMessages() async {
    final response = await rootBundle.loadString('assets/messages.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();

    setState(() {
      _messages = messages;
    });
  }
}