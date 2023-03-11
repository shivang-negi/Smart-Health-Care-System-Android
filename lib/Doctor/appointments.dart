import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;
import 'package:sqflite/sqflite.dart';

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
  late final value;

  @override
  void initState() {
    super.initState();
    _user = widget.number;
    print(_user);
    () async {
      final query = await FirebaseFirestore.instance
          .collection('Doctor')
          .limit(5)
          .get();
      var directory = await getApplicationDocumentsDirectory();
      path = '${directory.path}/chat_db.db';
      Database db = await openDatabase(path);
      var result = await db.query('chat');
      for(int i=0;i<result.length;i++) {
        number.add(result[i]['id']);
        name.add(result[i]['name']);
        for(int j=0;j<query.size;j++) {
          var num = (query.docs[j]['number']);
          var num2 = '${result[i]['id']}';
          if(num == num2) {
            image.add(query.docs[j]['picture']);
            break;
          }
          fetched = true;
        }
        if(result.isEmpty) fetched = true;
      }
      setState(() {
        value = number.length;
      });
    }();
  }

  _getSize() {
    setState(() {});
    if(number.isNotEmpty) return true;
    return false;
  }

  getFromServer() {
    setState(() {
    });
    return fetched;
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
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
      body: (getFromServer()==false)?const Center(child:CircularProgressIndicator()):
      (_getSize())? ListView.builder(
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
                        subtitle: Text(
                          'Start your consultation with ${name[index]}!',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                          ),
                        ),
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
                            print("pressed");
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