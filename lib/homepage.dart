import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'BookAppointment.dart';
import 'profile.dart';
import 'Symptoms.dart';
import 'Doctor/physician.dart';
import 'Doctor/appointments.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class HomePageWidget extends StatefulWidget {
  final String number;
  const HomePageWidget({Key? key,required this.number}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String name = "", city= "", state = "", profilepic = "https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg";
  String email = "";
  String ?place;
  String temp = "";
  bool set = false;
  int age = 0;

  void _determinePosition() async {
    if(set) {
      Fluttertoast.showToast(
          msg: "Location already set.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.lightGreenAccent,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return;
    }
    var serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled) {
      Fluttertoast.showToast(
          msg: "Location is disabled.", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 5, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0
      );
      return;
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(
            msg: "Permission denied.", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 5, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0
        );
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg: "Permission denied forever, enable from settings.", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 5, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0
      );
      return;
    }
    var curLocation = await Geolocator.getCurrentPosition();
    List<Placemark> pl  = await placemarkFromCoordinates(curLocation.latitude, curLocation.longitude);
    Placemark placeMark  = pl[0];
    if(placeMark.locality!=null) {
      temp = "${placeMark.subLocality},${placeMark.locality},${placeMark.administrativeArea}";
      place = temp;
      set = true;
      setState(() {});
    }
    else {
      Fluttertoast.showToast(
          msg: "Error setting location, please try again.", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 5, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0
      );
    }
  }

  @override
  void initState() {
    super.initState();
    place = temp;
    textController = TextEditingController();
    () async {
      final query = await FirebaseFirestore.instance
          .collection('Users')
          .limit(1)
          .where('Phone Number', isEqualTo: widget.number)
          .get();
      name = query.docs[0]['Name'];
      city = query.docs[0]['City'];
      age = query.docs[0]['Age'];
      state = query.docs[0]['State'];
      email = query.docs[0]['E-Mail'];
      if(query.docs[0]['Profile']!='') profilepic = query.docs[0]['Profile'];
      setState(() {});
    } ();
  }

  @override
  void dispose() {
    textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFF1F4F8),
      endDrawer: Drawer(
        elevation: 16,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
              child:
                Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: profilepic,
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          CircularProgressIndicator(value: downloadProgress.progress),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  Text(
                    '$name\n+91 ${widget.number}',
                    style: const TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold
                    )
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFFFFF),
                  minimumSize: const Size.fromHeight(40),
                ),
                onPressed: (){
                  print("your profile");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage(
                        name: name,
                        number: widget.number,
                        age: age,
                        city: city,
                        state: state,
                        email: email,
                        profile: profilepic)),
                  );
                  },
                child: const Text("Your Profile",
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold
                    )
                )
              )
            ),
            Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFFFFF),
                      minimumSize: const Size.fromHeight(40),
                    ),
                    onPressed: (){
                      print('Appointments page');
                      Navigator.push(context,MaterialPageRoute(builder: (context) => ChatHomePage(number: widget.number)));
                    },
                    child: const Text("Appointments",
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold
                        )
                    )
                )
            ),
            Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFFFFF),
                      minimumSize: const Size.fromHeight(40),
                    ),
                    onPressed: (){print("your orders");},
                    child: const Text("Your Orders",
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold
                        )
                    )
                )
            ),
            Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFFFFF),
                      minimumSize: const Size.fromHeight(40),
                    ),
                    onPressed: (){print("medical record");},
                    child: const Text("Medical Records",
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold
                        )
                    )
                )
            ),
            Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFFFFF),
                      minimumSize: const Size.fromHeight(40),
                    ),
                    onPressed: () async {
                      print("Log Out");
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.remove('Phone_Number');
                      Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context)=>LoginFirst()));
                      },
                    child: const Text("Log out",
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold
                        )
                    )
                )
            ),
          ],
        )
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFF050212),
        automaticallyImplyLeading: false,
        leading: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () async {
                print('icon pressed');
                _determinePosition();
              },
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: const Color(0xFF050212),
                  fixedSize: const Size(50,50)
              ),
              child: const Icon(Icons.location_on,
                color: Colors.white,
                size: 30,),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
              child: SelectionArea(
                  child: Text(
                    '$place',
                    style:
                    const TextStyle(
                      color: Color(0xFFF3F5F6),
                      fontFamily: 'Poppins',
                    ),
                  )),
            ),
          ],
        ),
        actions: const [],
        centerTitle: false,
        elevation: 0,
      ),

      body: SafeArea(
        child: GestureDetector(
          onTap: ()=>FocusScope.of(context).unfocus(),
          child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            children: [
              Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              backgroundColor: const Color(0xFFFFFFFF),
                              fixedSize: const Size(50,50)
                          ),
                          child: const Icon(
                            Icons.search,
                            color: Color(0xFF050212),
                            size: 30,
                          ),
                          onPressed: () {
                            print('search button pressed ...');
                          },
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: const AlignmentDirectional(0, 0.1),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                            child: TextFormField(
                              controller: textController,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Search for doctors',
                                hintStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
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
                                errorBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.black, fontFamily: 'Poppins'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(18, 18, 18, 15),
                child: Container(
                  width: 100,
                  height: 220,
                  decoration: BoxDecoration(
                    color: const Color(0xFF202871),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children:  const [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
                                  child: SelectionArea(
                                      child: Text(
                                        'Book Appointment with \nan Expert',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      )),
                                ),
                                Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
                                    child: Icon(
                                        Icons.navigate_next_outlined,
                                        color: Color(0xFFF8FAFB),
                                        size: 60
                                    )
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(20, 15, 0, 0),
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset('assets/images/1.jpg'),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      20, 15, 0, 0),
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset('assets/images/2.jpg'),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(20, 15, 0, 0),
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset('assets/images/3.jpg'),
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 15, 0, 0),
                                    child: Icon(
                                      Icons.add,
                                      color: Color(0xFFF8F2F2),
                                      size: 30,
                                    )
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(20, 15, 0, 0),
                                  child: SelectionArea(
                                      child: Text(
                                          'Skincare',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFF8F2F2)
                                          )
                                        // style: FlutterFlowTheme.of(context)
                                        //     .bodyText1
                                        //     .override(
                                        //   fontFamily: 'Poppins',
                                        //   color: Color(0xFFF8F2F2),
                                        // ),
                                      )),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 15, 0, 0),
                                  child: SelectionArea(
                                      child: Text(
                                          'Dentist',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFF8F2F2)
                                          )
                                      )),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 15, 0, 0),
                                  child: SelectionArea(
                                      child: Text(
                                          'Cardiologist',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFF8F2F2)
                                          )
                                      )),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 15, 0, 0),
                                  child: SelectionArea(
                                      child: Text(
                                          'More',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFF8F2F2)
                                          )
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child:   OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              side: const BorderSide(width: 0.0, color: Colors.transparent)
                          ),
                          child: const Text(''),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=> Appointment(number: widget.number)),
                            );
                            print('works1???');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 165,
                    height: 227,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x33000000),
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        color: const Color(0xFFF8F2F2),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0),
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                ),
                                child: Image.asset(
                                  'assets/images/doctor.png',
                                      width: 165,
                                  height: 160,
                                  fit: BoxFit.cover
                                )
                                // child: Image.network(
                                //   'https://static.independent.co.uk/s3fs-public/thumbnails/image/2019/01/23/11/video-doctor-230119.jpg?quality=75&width=982&height=726&auto=webp',
                                //   width: 165,
                                //   height: 160,
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              const Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(13, 0, 0, 0),
                                child: SelectionArea(
                                    child: Text(
                                        'Instant Video Consultation',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )
                                    )),
                              ),
                              const Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                child: SelectionArea(
                                    child: Text(
                                        'Connect within seconds',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Color(0xFF808386),
                                          fontFamily: 'Poppins',
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        )
                                    )),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child:   OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                side: const BorderSide(width: 0.0, color: Colors.transparent)
                            ),
                            child: const Text(''),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> Symptoms(number: widget.number)));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 165,
                    height: 227,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x33000000),
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        color: const Color(0xFFF8F2F2),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0),
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                ),
                                child: Image.asset(
                                    'assets/images/medicine.png',
                                    width: 165,
                                    height: 160,
                                    fit: BoxFit.cover
                                )
                                // child: Image.network(
                                //   'https://media.istockphoto.com/id/1300036753/photo/falling-antibiotics-healthcare-background.jpg?s=612x612&w=0&k=20&c=oquxJiLqE33ePw2qML9UtKJgyYUqjkLFwxT84Pr-WPk=',
                                //   width: 165,
                                //   height: 160,
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              const Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 6, 75, 0),
                                child: SelectionArea(
                                    child: Text(
                                        'Medicine',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                        )
                                    )),
                              ),
                              const Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 3, 5, 0),
                                child: SelectionArea(
                                    child: Text(
                                        'Essentials at your doorstep',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                          fontSize: 10,
                                          color: Color(0xFF808386),
                                        )
                                    )),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child:   OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                side: const BorderSide(width: 0.0, color: Colors.transparent)
                            ),
                            child: const Text(''),
                            onPressed: () {
                              print('works222???');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              Padding(
                  padding:  const EdgeInsetsDirectional.fromSTEB(18, 20, 18, 0),
                  child: Container(
                      width: 100,
                      height: 220,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x33000000),
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Stack(
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.asset(
                                        'assets/images/report.png',
                                        width: double.infinity,
                                        height: 180,
                                        fit: BoxFit.fill
                                    )
                                    // child: Image.network(
                                    //   'https://media.istockphoto.com/id/1305963775/vector/male-doctor-is-checking-medical-history-of-a-patient.jpg?s=612x612&w=0&k=20&c=QCzklF30ugWO-t7LVF0tJ5j-Gk4RlZIISeZ3-6Jlzik=',
                                    //   width: double.infinity,
                                    //   height: 180,
                                    //   fit: BoxFit.fill,
                                    // ),
                                  ),
                                  const Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding:
                                      EdgeInsetsDirectional.fromSTEB(0, 0, 8, 10),
                                      child: SelectionArea(
                                          child: Text(
                                              'Get free medical report analysis ',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.normal
                                              )
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child:   OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    side: const BorderSide(width: 0.0, color: Colors.transparent)
                                ),
                                child: const Text(''),
                                onPressed: () {
                                  print('works_medical_report???');
                                },
                              ),
                            ),
                          ]
                      )
                  )
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 15),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF1F4F8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.sick,
                        color: Color(0xFF29157A),
                        size: 40,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SelectionArea(
                              child: Text(
                                  'Not feeling too well?',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold
                                  )
                              )),
                          SelectionArea(
                              child: Text(
                                  'Treat common symtops with top specialists',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize:14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF57636C)
                                  )
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 95,
                height: 120,
                decoration: const BoxDecoration(
                  color: Color(0xFFF1F4F8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 95,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF1F4F8),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 75,
                                  height: 75,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    'assets/images/icon1.png',
                                    fit: BoxFit.fill
                                  ),
                                  // child: Image.network(
                                  //   'https://t1.thpservices.com/previewimage/gallil/f3b8fe2d72c92e4e468cefb96e0a9c57/esy-057855656.jpg',
                                  //   fit: BoxFit.fill,
                                  // ),
                                ),
                                const SelectionArea(
                                    child: Text(
                                        'Pimples &\nAcne',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF808386),
                                        )
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child:   OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  side: const BorderSide(width: 0.0, color: Colors.transparent)
                              ),
                              child: const Text(''),
                              onPressed: () {
                                print('button 1 works');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 95,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF1F4F8),
                      ),
                      child: Container(
                        width: 95,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF1F4F8),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 75,
                                    height: 75,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                        'assets/images/icon2.png',
                                        fit: BoxFit.fill
                                    ),
                                    // child: Image.network(
                                    //   'https://i.ytimg.com/vi/zi4thNp15qg/hqdefault.jpg',
                                    //   fit: BoxFit.fill,
                                    // ),
                                  ),
                                  const SelectionArea(
                                      child: Text(
                                          'Breathing\nProblems',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF808386),
                                          )
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child:   OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    side: const BorderSide(width: 0.0, color: Colors.transparent)
                                ),
                                child: const Text(''),
                                onPressed: () {
                                  print('button 2 works');
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 95,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF1F4F8),
                      ),
                      child: Container(
                        width: 95,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF1F4F8),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 75,
                                    height: 75,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                        'assets/images/icon3.png',
                                        fit: BoxFit.fill
                                    ),
                                    // child: Image.network(
                                    //   'https://img.freepik.com/premium-vector/cartoon-girl-anime-style-sports-uniform-shorts-tshirt-vector-art-toddler-character_456865-1280.jpg?w=2000',
                                    //   fit: BoxFit.fill,
                                    // ),
                                  ),
                                  const SelectionArea(
                                      child: Text(
                                          'Sickness in\ntoddlers',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF808386),
                                          )
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child:   OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    side: const BorderSide(width: 0.0, color: Colors.transparent)
                                ),
                                child: const Text(''),
                                onPressed: () {
                                  print('button 3 works');
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 95,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF1F4F8),
                      ),
                      child: Container(
                        width: 95,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF1F4F8),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 75,
                                    height: 75,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),

                                    child: Image.asset(
                                        'assets/images/icon4.png',
                                        fit: BoxFit.fill
                                    ),
                                  ),
                                  const SelectionArea(
                                      child: Text(
                                          'Fever',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF808386),
                                          )
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child:   OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    side: const BorderSide(width: 0.0, color: Colors.transparent)
                                ),
                                child: const Text(''),
                                onPressed: () {
                                  print('button 4 works');
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PhysicianWidget(number: widget.number)));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                child: Container(
                  width: 95,
                  height: 120,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF1F4F8),
                  ),
                  child: Container(
                    width: 95,
                    height: 120,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF1F4F8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 95,
                          height: 100,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF1F4F8),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 75,
                                      height: 75,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),

                                      child: Image.asset(
                                          'assets/images/icon5.png',
                                          fit: BoxFit.fill
                                      ),
                                    ),
                                    const SelectionArea(
                                        child: Text(
                                            'Icthy eyes',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF808386),
                                            )
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: double.infinity,
                                width: double.infinity,
                                child:   OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      side: const BorderSide(width: 0.0, color: Colors.transparent)
                                  ),
                                  child: const Text(''),
                                  onPressed: () {
                                    print('button 5 works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 95,
                          height: 100,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF1F4F8),
                          ),
                          child: Container(
                            width: 95,
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF1F4F8),
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: const AlignmentDirectional(0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: 75,
                                        height: 75,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),

                                        child: Image.asset(
                                            'assets/images/icon6.png',
                                            fit: BoxFit.fill
                                        ),
                                      ),
                                      const SelectionArea(
                                          child: Text(
                                              'Hypertension',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF808386),
                                              )
                                          )),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: double.infinity,
                                  width: double.infinity,
                                  child:   OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        side: const BorderSide(width: 0.0, color: Colors.transparent)
                                    ),
                                    child: const Text(''),
                                    onPressed: () {
                                      print('button 6 works');
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 95,
                          height: 100,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF1F4F8),
                          ),
                          child: Container(
                            width: 95,
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF1F4F8),
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: const AlignmentDirectional(0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: 75,
                                        height: 75,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),

                                        child: Image.asset(
                                            'assets/images/icon7.png',
                                            fit: BoxFit.fill
                                        ),
                                      ),
                                      const SelectionArea(
                                          child: Text(
                                              'Headache',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF808386),
                                              )
                                          )),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: double.infinity,
                                  width: double.infinity,
                                  child:   OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        side: const BorderSide(width: 0.0, color: Colors.transparent)
                                    ),
                                    child: const Text(''),
                                    onPressed: () {
                                      print('button 7 works');
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 95,
                          height: 100,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF1F4F8),
                          ),
                          child: Container(
                            width: 95,
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF1F4F8),
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: const AlignmentDirectional(0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: 75,
                                        height: 75,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),

                                        child: Image.asset(
                                            'assets/images/icon8.png',
                                            fit: BoxFit.fill
                                        ),
                                      ),
                                      const SelectionArea(
                                          child: Text(
                                              'Pain in chest',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF808386),
                                              )
                                          )),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: double.infinity,
                                  width: double.infinity,
                                  child:   OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        side: const BorderSide(width: 0.0, color: Colors.transparent)
                                    ),
                                    child: const Text(''),
                                    onPressed: () {
                                      print('button 8 works');
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                child: Container(
                  width: 100,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF1F4F8),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                    child: SizedBox(
                      height: 40,
                      width: 130,
                      child:   OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(width: 1.0, color: Colors.black)
                        ),
                        child: const Text('View all symptoms',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 16,
                            )
                        ),
                        onPressed: () {
                          print('viwe symp');
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Symptoms(number: widget.number)));
                        },
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                width: 100,
                height: 220,
                decoration: const BoxDecoration(
                  color: Color(0xFF202871),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    SelectionArea(
                        child: Text(
                            '[Application name]',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            )
                        )),
                    SelectionArea(
                        child: Text(
                            'Made by:',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            )
                        )),
                    SelectionArea(
                        child: Text(
                            'Shivang Negi\nShivam Rana\nPriyanshu Goyal\nRahul Negi',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )
                        )),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}