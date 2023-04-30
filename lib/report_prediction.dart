import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class ReportPrediction extends StatelessWidget {
  final String number;
  const ReportPrediction({Key? key, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        leading: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: const Color(0xFFFFFFFF),
              fixedSize: const Size(50,50),
              elevation: 0
          ),
          child: const Icon(Icons.arrow_back_rounded,
            color: Colors.black,
            size: 30,),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Padding(padding: EdgeInsetsDirectional.fromSTEB(15,15,15,15),
              // child: Text(
              //   "",
              //   style: TextStyle(
              //     fontSize: 40,
              //     fontFamily: 'Poppins',
              //     fontWeight: FontWeight.bold,
              //     color: Color(0xFF000000),
              //   ),
              // )
          ),
          Container(
              height: 80,
              width: double.infinity,
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 0.0),
                borderRadius: const BorderRadius.all(Radius.elliptical(40, 40)),
              ),
              child: Stack(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.analytics_outlined,
                        color: Colors.black54,
                        size: 24,),
                      const Text("Symptom Analysis",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      Padding(padding: const EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                          child: Container(
                            width: 75,
                            height: 75,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),

                            child: Image.asset(
                                'assets/images/analysis.png',
                                fit: BoxFit.fill
                            ),
                          )
                      )
                    ],
                  ),
                  Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.0),
                        borderRadius: const BorderRadius.all(Radius.elliptical(50, 50)),
                      ),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          print('predictor');
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>Symptoms(number: number)));
                        },
                      )
                  ),
                ],
              )
          ),
          Container(
              height: 80,
              width: double.infinity,
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 0.0),
                borderRadius: const BorderRadius.all(Radius.elliptical(40, 40)),
              ),
              child: Stack(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.analytics_outlined,
                        color: Colors.black54,
                        size: 24,),
                      const Text("Folliculitis Classifier",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      Padding(padding: const EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
                          child: Container(
                            width: 75,
                            height: 75,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),

                            child: Image.asset(
                                'assets/images/folli.png',
                                fit: BoxFit.fill
                            ),
                          )
                      )
                    ],
                  ),
                  Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.0),
                        borderRadius: const BorderRadius.all(Radius.elliptical(50, 50)),
                      ),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          // print('skin prediction');
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SkinClassifier(number: number)));
                        },
                      )
                  ),
                ],
              )
          ),
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15, 40, 15, 0),
            child: Text(
              "       *This is only a prediction model*\n    *It is not accurate 100% of the time*\n*For actual diagnosis, consult an expert*",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
          )
        ],
      ),
    );
  }
}


class SkinClassifier extends StatefulWidget {
  final String number;
  const SkinClassifier({Key? key, required this.number}) : super(key: key);

  @override
  State<SkinClassifier> createState() => _SkinClassifierState();
}

class _SkinClassifierState extends State<SkinClassifier> {

  String picture = "", display = "         Choose Image";
  var uuid;

  Future<String> getImageLink() async {
    File file = File(picture);
    Reference refer = FirebaseStorage.instance.ref();
    Reference ref_dir = refer.child('prediction');
    Reference upload = ref_dir.child(DateTime.now().toIso8601String());
    await upload.putFile(file);
    String link = await upload.getDownloadURL();
    return link;
  }

  Future<String> fetch() async {
    String getLink = await getImageLink();
    print(getLink);
    final queryParams = {
      'filename': uuid.v4().toString(),
      'image': getLink
    };
    final uri = Uri.https('8352-45-248-25-0.ngrok-free.app', '/endpoint', queryParams);
    var response = await http.get(uri);
    return response.body;
  }

  @override
  void initState() {
    uuid = const Uuid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        leading: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: const Color(0xFFFFFFFF),
              fixedSize: const Size(50,50),
              elevation: 0
          ),
          child: const Icon(Icons.arrow_back_rounded,
            color: Colors.black,
            size: 30,),
        ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: const EdgeInsetsDirectional.fromSTEB(15, 55, 15, 15),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54, width: 1),
                  borderRadius: BorderRadius.circular(40),
                ),
                child:ElevatedButton(onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      type: FileType.image
                  );
                  if(result==null) {return;}
                  else {
                    picture = result.files.first.path.toString();
                    String media = path.basename(picture);
                    display = "         ";
                    int i = 0;
                    for(i=0;i<media.length && i<14;i++) {
                      display+=media[i];
                    }
                    if(i<media.length) display+="...";
                  }
                  setState(() {});
                },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      shape: const StadiumBorder(),
                      minimumSize: const Size(80, 60),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.add_a_photo,color: Colors.black54, size: 30,),
                        Text((picture=="")?'         Choose Image':display,
                            style: const TextStyle(
                              fontSize: 24,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,)
                            )
                        ],
                      )
                ),
              )
          ),
          Padding(padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
              child: SizedBox(
                width: 200,
                child:ElevatedButton(onPressed: () {
                  if(picture=="") {
                    Fluttertoast.showToast(
                        msg: "No image added.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 5,
                        backgroundColor: Colors.redAccent,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                  else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Prediction Result"),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(context), child: const Text("EXIT")),
                            ],
                            content: FutureBuilder<String>(
                              future: fetch(),
                              builder: (BuildContext context,AsyncSnapshot<String> snapshot) {
                                if(snapshot.hasData) {
                                  String str = snapshot.data!;
                                  return Text(str);
                                }
                                else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                else {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      CircularProgressIndicator(),
                                      Text("This may take 15-30 seconds")
                                    ],
                                  );
                                }
                              }
                            ),
                          );
                        }
                    );
                  }
                },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.blue,
                      shape: const StadiumBorder(),
                      minimumSize: const Size(80, 60),
                    ),
                    child:const Text('Predict',style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,)
                        )
                    )
                ),
          )
        ],
      ),
    );
  }
}
