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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SymptomClassifier(number: number)));
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
    // print(getLink);
    final queryParams = {
      'type': "1",
      'filename': uuid.v4().toString(),
      'image': getLink
    };
    final uri = Uri.https('e056-103-248-123-91.ngrok-free.app', '/endpoint', queryParams);
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
                                      Text("This may take 30-40 seconds")
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


class SymptomClassifier extends StatefulWidget {
  final String number;
  const SymptomClassifier({Key? key, required this.number}) : super(key: key);

  @override
  State<SymptomClassifier> createState() => _SymptomClassifierState();
}

class _SymptomClassifierState extends State<SymptomClassifier> {

  TextEditingController searchController = TextEditingController();
  int selected = 0;
  var symptoms = ["Itching","Skin rash","Nodal skin eruptions","Continuous sneezing","Shivering","Chills","Joint pain","Stomach pain","Acidity","Ulcers on tongue","Muscle wasting","Vomiting","Burning micturition","Spotting urination","Fatigue","Weight gain","Anxiety","Cold hands and feets","Mood swings","Weight loss","Restlessness","Lethargy","Patches in throat","Irregular sugar level","Cough","High fever","Sunken eyes","Breathlessness","Sweating","Dehydration","indigestion","headache","yellowish skin","dark urine","nausea","loss of appetite","pain behind the eyes","back pain","constipation","abdominal pain","diarrhoea","mild fever","yellow urine","yellowing of eyes","acute liver failure","fluid overload","swelling of stomach","swelled lymph nodes","malaise","blurred and distorted vision","phlegm","throat irritation","redness of eyes","sinus pressure","runny nose","congestion","chest pain","weakness in limbs","fast heart rate","pain during bowel movements","pain in anal region","bloodystool","irritation in anus","neck pain","dizziness","cramps","bruising","obesity","swollen legs","swollen blood vessels","puffy face and eyes","enlarged thyroid","brittle nails","swollen extremeties","excessive hunger","extra marital contacts","drying and tingling lips","slurred speech","knee pain","hip joint pain","muscle weakness","stiff neck","swelling joints","movement stiffness","spinning movements","loss of balance","unsteadiness","weakness of one body side","loss of smell","bladder discomfort","foul smell ofurine","continuous feel of urine","passage of gases","internal itching","toxic look typhos","depression","irritability","muscle pain","altered sensorium","red spots over body","belly pain","abnormal menstruation","dischromic patches","watering from eyes","increased appetite","polyuria","family history","mucoid sputum","rusty sputum","lackof concentration","visual disturbances","receiving blood transfusion","receiving unsterile injections","coma","stomach bleeding","distention of abdomen","history of alcohol consumption","fluid overload","blood in sputum","prominent veins on calf","palpitations","painful walking","pus filled pimples","blackheads","scurring","skin peeling","silver like dusting","smalldents in nails","inflammatory nails","blister","red sore around nose","yellow crust ooze"];
  var checked = [];
  var uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    for(int i=0;i<symptoms.length;i++) {
      checked.add(false);
    }
  }

  void handleClick(String value) {
    switch (value) {
      case 'Clear choices':
        for(int i=0;i<checked.length;i++) {
          checked[i] = false;
        }
        selected = 0;
        setState(() {

        });
        break;
      case 'Details':
        showDialog(
          context: context,
            builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Model Details"),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text("EXIT")),
              ],
              content: const Text("This model's prediction results are limited to a specific set of diseases.")
            );
          }
        );
        break;
    }
  }

  var defaultValue = 0;

  List<Widget> getSymptoms() {
    var list = [];
    if(searchController.text.isEmpty) {
      for(int i=0;i<symptoms.length;i++) {
        list.add(i);
      }
    } else {
      String txt = searchController.text.toLowerCase();
      var len = txt.length;
      for(int i=0;i<symptoms.length;i++) {
        if(len>symptoms[i].length) continue;
        String cur = symptoms[i].substring(0,len);
        cur = cur.toLowerCase();
        if(txt==cur) {
          list.add(i);
        }
      }
    }

    if(list.isEmpty) {
      return [
        const Text("No such symptoms.", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'))
      ];
    }

    List<Widget> arr = [];
    for(int j=0;j<list.length;j++) {
      arr.add(
        CheckboxListTile(value: checked[list[j]], onChanged: (bool ?val) {
          if(val==null) return;
          checked[list[j]] = !checked[list[j]];
          selected = 0;
          for(int i=0;i<checked.length;i++) {
            if(checked[i]) {
              selected++;
            }
          }
          setState(() {});
        }, title: Text(symptoms[list[j]],style: const TextStyle(fontFamily: 'Poppins')))
      );
    }
    return arr;
  }

  Future<String> fetch(String str) async {
    final queryParams = {
      'type': "2",
      'input': str
    };
    final uri = Uri.https('e056-103-248-123-91.ngrok-free.app', '/endpoint', queryParams);
    var response = await http.get(uri);
    return response.body;
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
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert,
              color:Colors.black,
              size:30
            ),
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Clear choices', 'Details'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),
            child: Container(
              width: double.infinity,
              // height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFF2EAEA),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: Icon(Icons.search,
                        color: Colors.black,
                        size: 28,),
                  ),
                  // Expanded(
                  //   child:
                  Expanded(child: TextFormField(
                      controller: searchController,
                      autofocus: false,
                      obscureText: false,
                      onChanged: (String str) {
                        setState(() {

                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search for Symptoms',
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          color: Color(0xFF57636C),
                          fontWeight: FontWeight.bold,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF2EAEA),
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  )
                  // ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: getSymptoms()
              )
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                child: Text('Selected:$selected',
                  style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  ),
                  ),
              ),
              Padding(padding: const EdgeInsetsDirectional.fromSTEB(15, 5, 5, 10),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(onPressed: () {
                    String str = "";
                    for(bool x in checked) {
                      if(x) {
                        str+='1';
                      } else {
                        str+='0';
                      }
                    }
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Prediction Result"),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(context), child: const Text("EXIT")),
                            ],
                            content: FutureBuilder<String>(
                                future: fetch(str),
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
                                        Text("This may take 5-10 seconds")
                                      ],
                                    );
                                  }
                                }
                            ),
                          );
                        }
                    );
                  },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text('Predict Results',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}






