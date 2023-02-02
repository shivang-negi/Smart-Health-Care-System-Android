import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterWidget extends StatefulWidget {
  final String number;
  const RegisterWidget({Key? key ,required this.number}) : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  bool isMediaUploading = false;
  String uploadedFileUrl = '';

  String stateValue = "";
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final cityController1 = TextEditingController();
  final yourNameController = TextEditingController();
  final ageController = TextEditingController();

  @override
  void dispose() {
    cityController1.dispose();
    yourNameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  String val = "State";
  var items = [
  'State',
  'Andhra Pradesh',
  'Arunachal Pradesh',
  'Assam',
  'Bihar',
  'Chhattisgarh',
  'Goa',
  'Gujarat',
  'Haryana',
  'Himachal Pradesh',
  'Jammu and Kashmir',
  'Jharkhand',
  'Karnataka',
  'Kerala',
  'Madhya Pradesh',
  'Maharashtra',
  'Manipur',
  'Meghalaya',
  'Mizoram',
  'Nagaland',
  'Odisha',
  'Punjab',
  'Rajasthan',
  'Sikkim',
  'Tamil Nadu',
  'Telangana',
  'Tripura',
  'Uttar Pradesh',
  'Uttarakhand',
  'West Bengal'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
            iconSize: 60,
            splashRadius: 30,
            color: Colors.white,
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              print('IconButton pressed ...');
            },
          ),
          title: const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
            child: Text(
              'Create Profile',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 24,
              ),
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {},
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Color(0xFFDBE2E7),
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                        child: Container(
                          width: 90,
                          height: 90,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            'https://thumbs.dreamstime.com/b/upload-profile-thin-line-vector-icon-upload-profile-vector-icon-elements-mobile-concept-web-apps-thin-line-icons-146032604.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
              child: TextFormField(
                controller: yourNameController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Your Full Name',
                  labelStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFF57636C),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  hintStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFF57636C),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFF1F4F8),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFF1F4F8),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                ),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFF101213),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: null,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
              child: TextFormField(
                controller: cityController1,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Your City',
                  labelStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFF57636C),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  hintStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFF57636C),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFF1F4F8),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFF1F4F8),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                ),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFF101213),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: null,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 12),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: val,
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        val = value!;
                        stateValue = value;
                      });
                    },
                    // width: double.infinity,
                    // height: 56,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFF101213),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color(0xFF57636C),
                      size: 15,
                    ),
                    elevation: 1,
                  ),
                ),
              )
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 5),
              child: TextFormField(
                controller: ageController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Age',
                  labelStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFF57636C),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  hintStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFF57636C),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFF1F4F8),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFF1F4F8),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                ),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFF101213),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: null,
                keyboardType: TextInputType.number,
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 0.05),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                child: ElevatedButton(
                  onPressed: () async {
                    String name = yourNameController.text.trim();
                    String city = cityController1.text.trim();
                    if(name=="" || city=="" || ageController.text.trim()=="" || stateValue=="") {
                      Fluttertoast.showToast(
                          msg: "Invalid Data",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 5,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      // final query = await FirebaseFirestore.instance
                      //     .collection('Users')
                      //     .limit(10)
                      //     .where('Phone Number', isEqualTo: '+91121')
                      //     .get();

                      // if(query.docs.isEmpty) print("not exist");
                      // for (var doc in query.docs) {
                      //   String name = doc.get('Name');
                      //
                      //   print(name);
                      // }
                    }
                    else {
                      await FirebaseFirestore.instance.collection('Users').add({
                        'Name': name,
                        'City': city,
                        'State': stateValue,
                        'Age': int.parse(ageController.text.trim()),
                        'Phone Number': widget.number
                      });
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString('Phone_Number', widget.number);
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context)=> HomePageWidget(
                            number: widget.number
                          )
                      ));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4B39EF),
                    fixedSize: const Size(175, 50),
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    "Save Changes",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
