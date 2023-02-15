import 'package:app/CheckUserSignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'register.dart';

class LoginFirst extends StatefulWidget {
  LoginFirst({Key?key}) : super(key:key);
  static String verify = "";

  @override
  State<LoginFirst> createState() => _LoginFirstState();
}

class _LoginFirstState extends State<LoginFirst> {
  final phoneNumber = TextEditingController();
  bool signedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await CheckUserSignIn.getUserSignInStatus().then((value) {
      if(value!=null) {
        signedIn = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: double.infinity,
            height:100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Align(
                  alignment: AlignmentDirectional(0.3,0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                    child: Text(
                      'Health App',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000847),
                        fontSize: 36
                      )
                    ),
                ),
                ),
                Container(
                  width: 75,
                  height: 75,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    'https://www.shutterstock.com/image-illustration/white-smartphone-heart-rate-monitor-260nw-1500856202.jpg',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Sign in with your phone number",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF808386)
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(padding: EdgeInsetsDirectional.fromSTEB(55, 0, 0, 0),
                        child: Text(
                          "+91",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 30, 0),
                        child: TextFormField(
                          controller: phoneNumber,
                          autofocus: false,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          decoration: InputDecoration(
                            hintText: 'Enter Phone Number',
                            hintStyle: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF1F4F8),
                          ),
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    var str = phoneNumber.text;
                    if(str.length!=10) {
                      Fluttertoast.showToast(
                          msg: "Phone Number must be 10 digits",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 5,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      return;
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context)=> OtpWindow(text: str)
                        )
                    );
                    // print(str);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF202871),
                    fixedSize: const Size(175, 50),
                  ),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16
                      ),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OtpWindow extends StatefulWidget {
  final String text;

  const OtpWindow({Key ?key,required this.text}) : super(key: key);

  @override
  State<OtpWindow> createState() => _OtpWindowState();
}

class _OtpWindowState extends State<OtpWindow> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  var ch1 = '', ch2 = '', ch3 = '', ch4 = '', ch5 = '', ch6 = '';

  @override
  void initState() {
    super.initState();

    () async {

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.text}',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          LoginFirst.verify = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      setState(() {});
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
            child: Text(
              'Enter OTP',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: Color(0xFF202871),
                fontSize: 48,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
            child: Text(
              "The OTP has been send to the phone number +91 ${widget.text}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: Color(0xFF808386),
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(15, 50, 15, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                  SizedBox(
                    height: 60,
                    width: 48,
                    child: TextField(
                      onChanged: (value) {
                        if(value.length==1) {
                        FocusScope.of(context).nextFocus();
                        ch1 = value;
                        } else {
                          ch1 = '';
                        }
                    },
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                SizedBox(
                  height: 60,
                  width: 48,
                  child: TextField(
                    onChanged: (value) {
                      if(value.length==1) {
                        FocusScope.of(context).nextFocus();
                        ch2 = value;
                      } else {
                        FocusScope.of(context).previousFocus();
                        ch2 = '';
                      }
                    },
                    style: Theme.of(context).textTheme.headline6,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 48,
                  child: TextField(
                    onChanged: (value) {
                      if(value.length==1) {
                        FocusScope.of(context).nextFocus();
                        ch3 = value;
                      } else {
                        FocusScope.of(context).previousFocus();
                        ch3 = '';
                      }
                    },
                    style: Theme.of(context).textTheme.headline6,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 48,
                  child: TextField(onChanged: (value) {
                    if(value.length==1) {
                      FocusScope.of(context).nextFocus();
                      ch4 = value;
                    } else {
                      FocusScope.of(context).previousFocus();
                      ch4 = '';
                    }
                  },
                    style: Theme.of(context).textTheme.headline6,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 48,
                  child: TextField(
                    onChanged: (value) {
                      if(value.length==1) {
                        FocusScope.of(context).nextFocus();
                        ch5 = value;
                      } else {
                        FocusScope.of(context).previousFocus();
                        ch5 = '';
                      }
                    },
                    style: Theme.of(context).textTheme.headline6,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 48,
                  child: TextField(onChanged: (value) {
                    if(value.length==1) {
                      ch6 = value;
                    } else {
                      ch6 = '';
                      FocusScope.of(context).previousFocus();
                    }
                  },
                    style: Theme.of(context).textTheme.headline6,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
            child: ElevatedButton(
              onPressed: () async {
                final String code = ch1 + ch2 + ch3 + ch4 + ch5 + ch6;
                // print(code);LoginFirst.verify    112345
                try {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: LoginFirst.verify, smsCode: code);
                  await auth.signInWithCredential(credential);

                  final query = await FirebaseFirestore.instance
                      .collection('Users')
                      .limit(1)
                      .where('Phone Number', isEqualTo: widget.text)
                      .get();

                  // final query2 = await FirebaseFirestore.instance
                  //     .collection('Doctor')
                  //     .limit(1)
                  //     .where('number', isEqualTo: widget.text)
                  //     .get();

                  if(query.docs.isEmpty /*&& query2.docs.isEmpty*/) {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=> RegisterWidget(number: widget.text)
                    ));
                  }
                  else {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString('Phone_Number', widget.text);
                    Navigator.pushAndRemoveUntil<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => HomePageWidget(
                            number: widget.text
                        ),
                      ),
                          (route) => false,//if you want to disable back feature set to false
                    );
                  }
                }
                catch(e) {
                  Fluttertoast.showToast(
                      msg: "Incorrect OTP",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 5,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF202871),
                fixedSize: const Size(175, 50),
              ),
              child: const Text(
                "Sign In",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF202871),
                fixedSize: const Size(175, 50),
              ),
              child: const Text(
                "Back",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
