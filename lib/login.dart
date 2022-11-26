import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homepage.dart';

class LoginFirst extends StatelessWidget {
  LoginFirst({Key?key}) : super(key:key);
  final phoneNumber = TextEditingController();
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
                  onPressed: () {
                    // var str = phoneNumber.text.length;
                    // print(str);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const OtpWindow()));
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

class OtpWindow extends StatelessWidget {
  const OtpWindow({Key? key}) : super(key: key);

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
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
            child: Text(
              'The OTP has been send to the phone number +91 9557641937',
              textAlign: TextAlign.center,
              style: TextStyle(
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
                        if(value.length==1) FocusScope.of(context).nextFocus();
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
                      } else {
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
                SizedBox(
                  height: 60,
                  width: 48,
                  child: TextField(
                    onChanged: (value) {
                      if(value.length==1) {
                        FocusScope.of(context).nextFocus();
                      } else {
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
                SizedBox(
                  height: 60,
                  width: 48,
                  child: TextField(onChanged: (value) {
                    if(value.length==1) {
                      FocusScope.of(context).nextFocus();
                    } else {
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
                SizedBox(
                  height: 60,
                  width: 48,
                  child: TextField(
                    onChanged: (value) {
                      if(value.length==1) {
                        FocusScope.of(context).nextFocus();
                      } else {
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
                SizedBox(
                  height: 60,
                  width: 48,
                  child: TextField(onChanged: (value) {
                    if(value.isEmpty) {
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
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePageWidget()));
                // print("pressed");
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
