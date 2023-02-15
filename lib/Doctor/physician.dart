import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PhysicianWidget extends StatefulWidget {
  const PhysicianWidget({Key? key}) : super(key: key);

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

  @override
  void initState() {
    super.initState();
    () async {
      final query = await FirebaseFirestore.instance
          .collection('Doctor')
          .limit(5)
          .get();
      if(query.docs.isEmpty) {
        print("emtpy");
        return;
      }
      else {
        print("${query.docs.length} ");
      }
      for(int i=0;i<query.size;i++) {
        name.add(query.docs[i]['Name']);
        years.add(query.docs[i]['years']);
        number.add(query.docs[i]['number']);
        pic.add(query.docs[i]['picture']);
      }
      setState(() {});
    }();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
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
                      child: Image.network(
                        pic[index],
                        fit: BoxFit.contain,
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
                        print('button $index pressed');
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
