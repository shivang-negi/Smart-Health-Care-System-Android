import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class Orders extends StatefulWidget {
  final String number;
  const Orders({Key? key, required this.number}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {

  late String path;
  late Database db;

  initdb() async {
    var db = await openDatabase(path, version: 1, onCreate: (db,version) async {
      await db.execute("CREATE TABLE IF NOT EXISTS medicine(name TEXT PRIMARY KEY, image TEXT NOT NULL, cost TEXT NOT NULL)");
    });
    return db;
  }

  Future<List<List<String>>> getResult() async {
    var directory = await getApplicationDocumentsDirectory();
    path = '${directory.path}/chat_db.db';
    db = await initdb();
    await db.execute("CREATE TABLE IF NOT EXISTS medicine(name TEXT PRIMARY KEY, image TEXT NOT NULL, cost TEXT NOT NULL)");
    var result = await db.query('medicine');
    List<List<String>> ans = [];
    for(int i=0;i<result.length;i++) {
      List<String> temp = [];
      temp.add(result[i]['name'].toString());
      temp.add(result[i]['image'].toString());
      temp.add(result[i]['cost'].toString());

      ans.add(temp);
    }
    return ans;
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
            'Your Orders',
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
        body: FutureBuilder<List<List<String>>>(
          future:  getResult(),
          builder: (BuildContext context, AsyncSnapshot<List<List<String>>> snapshot) {
            if (snapshot.hasData) {
              List<List<String>>? data = snapshot.data;
              if(data?.length == 0) {
                return const Center(
                  child: Text(
                    "You have no orders.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: data?.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                itemBuilder: (context,index) {
                  return Container(
                    height: 80,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                            width: 60,
                            height: 60,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CachedNetworkImage(
                              imageUrl: data![index][1],
                              height: 100,
                              width:  100,
                              fit: BoxFit.fill,
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  CircularProgressIndicator(value: downloadProgress.progress),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          )
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data![index][0],style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19
                              ),
                              ),
                              Text(data[index][2],style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12
                              ),
                              ),
                            ],
                          )
                        )
                      ],
                    ),
                  );
                }
              );
              return Text(data.toString());
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Error loading data, please try again.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  "You have no orders.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),
                ),
              );
            }
          },
        )
    );
  }
}

class Records extends StatelessWidget {
  final String number;
  const Records({Key? key, required this.number}) : super(key: key);

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
            'Medical Records',
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
        body: const Center(
          child: Text(
            "No medical records present.",
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