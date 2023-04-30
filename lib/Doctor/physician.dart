import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;
import 'package:sqflite/sqflite.dart';
import 'SocketManager.dart';
import 'appointments.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class PhysicianWidget extends StatefulWidget {
  final String number;
  PhysicianWidget({Key? key, required this.number}) : super(key: key);

  @override
  _PhysicianWidgetState createState() => _PhysicianWidgetState();
}

class _PhysicianWidgetState extends State<PhysicianWidget> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  List<String> name = [];
  List<String> years = [];
  List<String> pic = [];
  List<String> number = [];
  late String path;
  late IO.Socket _socket;

  handleMessageRequest(data) {
    print(data);
  }

  @override
  void initState() {
    super.initState();
    _socket = SocketManager.getSocket();
    _socket.on('newMessageRequest',(data)=>handleMessageRequest(data));
    () async {
      final query = await FirebaseFirestore.instance
          .collection('Doctor')
          .limit(5)
          .get();
      for(int i=0;i<query.size;i++) {
        name.add(query.docs[i]['Name']);
        years.add(query.docs[i]['years']);
        number.add(query.docs[i]['number']);
        pic.add(query.docs[i]['picture']);
      }
      setState(() {});
    }();
    () async {
      var directory = await getApplicationDocumentsDirectory();
      path = '${directory.path}/chat_db.db';
      Database db = await initdb();
      await db.execute("CREATE TABLE IF NOT EXISTS chat(id INTEGER PRIMARY KEY, name TEXT NOT NULL, image TEXT NOT NULL)");
    }();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    SocketManager.dispose();
    super.dispose();
  }

  initdb() async{
    var db = await openDatabase(path, version: 1, onCreate: (db,version) async {
      await db.execute("CREATE TABLE IF NOT EXISTS chat(id INTEGER PRIMARY KEY, name TEXT NOT NULL, image TEXT NOT NULL)");
    });
    return db;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
        actions: const [],
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 0, 0),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF1F4F8),
                  ),
                  child: const Text(
                    'Consult with a top general physician:',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ListView.builder(
                itemCount: name.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 15),
                itemBuilder: (context,index) {
                  return ListTile(
                    leading: Container(
                      width: 60,
                      height: 60,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: pic[index],
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
                    subtitle: Text(
                      '${years[index]} years of experience',
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                      ),
                    ),
                    trailing: TextButton(
                      child: const Text(
                        'CONSULT',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text("Consult with doctor ${name[index]}"),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context), child: const Text("No")),
                                TextButton(onPressed: () {
                                  () async {
                                    Database db = await initdb();
                                    var result = await db.query('chat',where: 'id = ${number[index]}');
                                    if(result.isEmpty) {
                                      var profile = ('https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg');
                                      final query = await FirebaseFirestore.instance
                                          .collection('Doctor')
                                          .limit(1)
                                          .where('number', isEqualTo: number[index].toString())
                                          .get();
                                      if(query.size>0 && query.docs[0]['picture']!='') {
                                        profile = query.docs[0]['picture'];
                                        print(query.docs[0]['picture']);
                                      }
                                      print(profile);
                                      await db.execute('INSERT INTO chat VALUES(${number[index]},"${name[index]}","$profile")');
                                    }
                                    _socket.emit('message_request',{
                                      'receiver': number[index],
                                      'sender'  : widget.number
                                    });
                                  }();
                                  Future.delayed(const Duration(milliseconds: 500), () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatHomePage(number: widget.number)));
                                  });
                                }, child: const Text("Yes"))
                              ],
                            );
                          }
                        );
                      },
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
