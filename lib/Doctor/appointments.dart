import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'Chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;
import 'package:sqflite/sqflite.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:async';
import 'SocketManager.dart';

class ChatHomePage extends StatefulWidget {
  final String number;
  ChatHomePage({Key? key, required this.number}) : super(key: key);

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {

  late String path;
  late String _user;
  bool fetched = false;
  final _unfocusNode = FocusNode();
  List<dynamic> name = [];
  List<dynamic> number = [];
  List<dynamic> image = [];
  var value = -1;
  late IO.Socket _socket;
  late Timer _timer;
  late Database db;
  var result;

  checkNewMessages() {
    _socket.emit('check_messages',{'user': widget.number});
  }

  addNewMessages(data) async {

    for(int i=0;i<data.length;i++) {

      var num = data[i]['sender'];
      bool flag = false;
      for(var i=0;i<number.length;i++) {
        if(num.toString()==number[i].toString()) {
          flag = true;
          break;
        }
      }
      if(flag) continue;
      final query = await FirebaseFirestore.instance
          .collection('Users')
          .limit(1)
          .where('Phone Number', isEqualTo: num)
          .get();

      var _name = query.docs[0]['Name'];
      var _profilepic = 'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg';
      if(query.docs[0]['Profile']!='') {
        _profilepic = query.docs[0]['Profile'];
      }

      name.add(_name);
      image.add(_profilepic);
      number.add(num);

      db.execute('INSERT INTO chat VALUES($num,"$_name","$_profilepic")');
    }
    setState(() {
      value = number.length;
    });
  }

  @override
  void initState() {
    super.initState();
    _user = widget.number;
    _socket = SocketManager.getSocket();
    _timer = Timer.periodic(const Duration(seconds: 3), (_)=>checkNewMessages());
    _socket.on('AddNewMessages', (data) => addNewMessages(data));

    () async {
      try {
        var directory = await getApplicationDocumentsDirectory();
        path = '${directory.path}/chat_db.db';
        db = await openDatabase(path, version: 1, onCreate: (db,version) async {
          await db.execute("CREATE TABLE IF NOT EXISTS chat(id INTEGER PRIMARY KEY, name TEXT NOT NULL, image TEXT NOT NULL)");
        });
        result = await db.query('chat');
        for (int i = 0; i < result.length; i++) {
          number.add(result[i]['id']);
          name.add(result[i]['name']);
          image.add(result[i]['image']);
        }
      }
      catch(e) {
        value = 0;
      }
      setState(() {
        value = number.length;
      });
    }();
  }

  _getSize() {
    setState(() {});
    if(value==-1) return true;
    return false;
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    SocketManager.dispose();
    print('cancel');
    _timer.cancel();
    super.dispose();
  }

  Future<String> getLastMessage(number,naam) async {
    var res = await db.query('room$number',orderBy: 'id DESC',limit: 1);
    String str = "Start your consultation with $naam!";
    if(res.isNotEmpty) {
      if(res[0]['type']=='text') {
        str = res[0]['message'] as String;
      } else if(res[0]['type']=='image') {
        str = 'image:${res[0]['message'] as String}';
      } else {
        str = 'file:${res[0]['message'] as String}';
      }
    }
    if(str.length>35) str = '${str.substring(0,32)}...';
    return str;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
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
          'Appointments',
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
      body:
      (_getSize()==true)?const Center(child:CircularProgressIndicator()):
      (value>0)? ListView.builder(
              itemCount: number.length,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              itemBuilder: (context,index) {
                return Container(
                  height: 80,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      ListTile(
                        leading: Container(
                          width: 60,
                          height: 60,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: image[index],
                            height: 100,
                            width:  100,
                            fit: BoxFit.fill,
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                CircularProgressIndicator(value: downloadProgress.progress),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                        title: Text(name[index],
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        subtitle: FutureBuilder<String>(
                          future: getLastMessage(number[index], name[index]),
                          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                            if (snapshot.hasData) {
                              String? str = snapshot.data;
                              return Text(str!, style: const TextStyle(
                                fontFamily: 'Poppins',
                              ));
                            } else if (snapshot.hasError) {
                              return Text("Start your consultation with ${name[index]}!", style: const TextStyle(
                                fontFamily: 'Poppins',
                              ));
                            } else {
                              return Text("Start your consultation with ${name[index]}!", style: const TextStyle(
                                fontFamily: 'Poppins',
                              ));
                            }
                          },
                        )
                      )
                      ,SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child:   OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              side: const BorderSide(width: 0.0, color: Colors.transparent)
                          ),
                          child: const Text(''),
                          onPressed: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context)=> ChatUI(
                                user: _user,
                                receiver: number[index].toString(),
                              receiver_name: name[index],
                              path: path
                            )));
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
          ): const Center(
          child: Text(
            "No appointments yet.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 17
            ),
          ),
        )
      );
  }
}