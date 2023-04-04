import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'SocketManager.dart';

class ChatUI extends StatefulWidget {
  final String user,receiver,receiver_name,path;
  const ChatUI({Key ?key,
    required this.user,
    required this.receiver,
    required this.receiver_name,
    required this.path
  }): super(key:key);

  @override
  State<ChatUI> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatUI> {
  List<types.Message> _messages = [];
  late IO.Socket _socket;
  late String room;
  late Database database;

  Receive(data) {
    print(data);
    final textMessage = types.TextMessage(
      author: types.User(id: widget.receiver),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: data['msg'],
    );
    database.execute("INSERT INTO room${widget.receiver} VALUES(${DateTime.now().millisecondsSinceEpoch},'${data['msg']}','${widget.receiver}','text')");
    _addMessage(textMessage);
  }

  ReceiveImage(data) async {
    print(data);
    final response = await http.get(Uri.parse(data['url']));
    final documentDirectory = await getApplicationDocumentsDirectory();
    final file = File("${documentDirectory.path}/${DateTime.now().toIso8601String()}.png");
    file.writeAsBytesSync(response.bodyBytes);

    print(file.path);
    final bytes = await file.readAsBytes();
    final image = await decodeImageFromList(bytes);

    final message = types.ImageMessage(
      author: types.User(id: widget.receiver),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      height: image.height.toDouble(),
      id: const Uuid().v4(),
      name: DateTime.now().toIso8601String(),
      size: bytes.length,
      uri: file.path,
      width: image.width.toDouble(),
    );

    _addMessage(message);
    database.execute("INSERT INTO room${widget.receiver} VALUES(${DateTime.now().millisecondsSinceEpoch},'${file.path}','${widget.receiver}','image')");
  }

  static var httpClient = new HttpClient();
  Future<File> _downloadFile(String url, String filename) async {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  ReceiveFile(data) async {
    String filename = data['filename'];
    File file = await _downloadFile(data['url'],filename);
    int bytes = await file.length();
    // print(data);
    // print(file.path);
    // print(bytes);
    final message = types.FileMessage(
      author: types.User(id: widget.receiver),
      createdAt: DateTime
          .now()
          .millisecondsSinceEpoch,
      id: const Uuid().v4(),
      mimeType: lookupMimeType(file.path),
      name: filename,
      size: bytes,
      uri: file.path,
    );

    _addMessage(message);
    database.execute("INSERT INTO room${widget.receiver} VALUES(${DateTime.now().millisecondsSinceEpoch},'${file.path}','${widget.receiver}','file')");
  }

  addNew(data) async {
    for(var i=0;i<data.length;i++) {
      if(data[i]['type']=='text') {
        await Receive(data[i]);
      } else if(data[i]['type']=='image') {
        await ReceiveImage(data[i]);
      }
      else if(data[i]['type']=='file') {
        await ReceiveFile(data[i]);
      }
    }
  }

  _connect() {
    _socket.onConnect((data) => print("Connection established"));
    _socket.onConnectError((data) => (data) {
      Fluttertoast.showToast(
          msg: "Error connecting to server",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    });
    _socket.onDisconnect((data) => print("Disconnected"));
    _socket.emit('join',{'room': room,'user':widget.user, 'receiver':widget.receiver});
    _socket.on('oldmsgs',(data)=>addNew(data));
    _socket.on('new_msg',(data)=>Receive(data));
    _socket.on('receiveImage',(data)=>ReceiveImage(data));
    _socket.on('receiveFile',(data)=>ReceiveFile(data));
  }

  @override
  void initState() {
    if(int.parse(widget.user) < int.parse(widget.receiver)) {
      room = "${widget.user} ${widget.receiver}";
    } else {
      room = "${widget.receiver} ${widget.user}";
    }
    print(room);
    _socket = SocketManager.getSocket();

    _loadMessages();
    _connect();
    super.initState();
  }

  @override
  void dispose() {
    // _socket.disconnect();
    // _socket.close();
    SocketManager.dispose();
    super.dispose();
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
      title: Text(
        widget.receiver_name,
        style: const TextStyle(
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
      user: types.User(id: widget.user),
    ),
  );
  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
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


  //=====================FILE======================
  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: types.User(id: widget.user),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      _addMessage(message);
      database.execute("INSERT INTO room${widget.receiver} VALUES(${DateTime.now().millisecondsSinceEpoch},'${result.files.single.path}','${widget.user}','file')");

      String FileUrl = "";
      File file = File(result.files.single.path!);
      Reference refer = FirebaseStorage.instance.ref();
      Reference ref_dir = refer.child('files');

      Reference upload = ref_dir.child(const Uuid().v4());
      try {
        await upload.putFile(file);
        FileUrl = await upload.getDownloadURL();
      } catch (e) {
        Fluttertoast.showToast(
            msg: "Error sending file, try again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      }
      print(FileUrl);
      _socket.emit('fileMessage',{
        'url': FileUrl,
        'room': room,
        'sender': widget.user,
        'receiver': widget.receiver,
        'filename': result.files.single.name
      });
    }
  }


  //====================IMAGE=====================
  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: types.User(id: widget.user),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
      database.execute("INSERT INTO room${widget.receiver} VALUES(${DateTime.now().millisecondsSinceEpoch},'${result.path}','${widget.user}','image')");

      // Saving image in firebase storage and send it to receiver
      String imageUrl = "";
      File file = File(result.path);
      Reference refer = FirebaseStorage.instance.ref();
      Reference ref_dir = refer.child('images');

      Reference upload = ref_dir.child(const Uuid().v4());
      try {
        await upload.putFile(file);
        imageUrl = await upload.getDownloadURL();
      } catch (e) {
        Fluttertoast.showToast(
            msg: "Error sending image, try again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      }
      print(imageUrl);
      _socket.emit('imageMessage',{
        'url': imageUrl,
        'room': room,
        'sender': widget.user,
        'receiver': widget.receiver
      });
    }
  }


  //=====================TEXT============================
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

  void _handlePreviewDataFetched(
      types.TextMessage message,
      types.PreviewData previewData,
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
      author: types.User(id: widget.user),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    _socket.emit('message',{
      'msg': message.text,
      'room': room,
      'sender': widget.user,
      'receiver': widget.receiver
    });
    database.execute("INSERT INTO room${widget.receiver} VALUES(${DateTime.now().millisecondsSinceEpoch},'${message.text}','${widget.user}','text')");
    _addMessage(textMessage);
  }

  void _loadMessages() async {
    database = await initdb();
    await database.execute("CREATE TABLE IF NOT EXISTS room${widget
        .receiver}(id INTEGER PRIMARY KEY, message TEXT NOT NULL, sender TEXT NOT NULL, type TEXT NOT NULL)");
    var result = await database.query('room${widget.receiver}');
    for (int i = 0; i < result.length; i++) {
      var mp = result[i];
      var id = mp['id'] as int;
      var send = mp['sender'].toString();
      var msg = mp['message'].toString();
      var type = mp['type'].toString();
      if (type == 'text') {
        final textMessage = types.TextMessage(
          author: types.User(id: send),
          createdAt: id,
          id: const Uuid().v4(),
          text: msg,
        );
        setState(() {
          _messages.insert(0, textMessage);
        });
      }
      else if (type == 'image') {
        final result = await XFile(msg);

        final bytes = await result.readAsBytes();
        final image = await decodeImageFromList(bytes);

        final message = types.ImageMessage(
          author: types.User(id: send),
          createdAt: DateTime
              .now()
              .millisecondsSinceEpoch,
          height: image.height.toDouble(),
          id: const Uuid().v4(),
          name: result.name,
          size: bytes.length,
          uri: result.path,
          width: image.width.toDouble(),
        );

        _addMessage(message);
      }
      else if(type == 'file') {
        File file = File(msg);
        int bytes = await file.length();
        final message = types.FileMessage(
          author: types.User(id: send),
          createdAt: DateTime
              .now()
              .millisecondsSinceEpoch,
          id: const Uuid().v4(),
          mimeType: lookupMimeType(file.path),
          name: File(msg).uri.pathSegments.last,
          size: bytes,
          uri: file.path,
        );

        _addMessage(message);
      }
    }
  }

  initdb() async{
    var db = await openDatabase(widget.path, version: 1, onCreate: (db,version) async {
      await db.execute("CREATE TABLE room${widget.receiver}(id INTEGER PRIMARY KEY, message TEXT NOT NULL, sender TEXT NOT NULL)");
    });
    return db;
  }
}