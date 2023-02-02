import 'package:flutter/material.dart';

class Appointment extends StatefulWidget {
  const Appointment({Key? key}) : super(key: key);

  @override
  _Appointment createState() => _Appointment();
}

class _Appointment extends State<Appointment> {
  String? dropDownValue;
  TextEditingController? textController1;
  TextEditingController? textController2;
  String? radioButtonValue;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    textController1?.dispose();
    textController2?.dispose();
    super.dispose();
  }

  var options = [
  'Knee and Joints related\nOrthopedics',
  'Eye related\nOpthamology',
  'General Surgery\nGeneral Surgery',
  'Anus related\nProctology',
  'Hair loss related\nHair treatment',
  'Cosmic Surgery related\nCosmetic',
  'Fertility specific\nFertility',
  'Kidney related\nUrology',
  'Show all surgical Ailment'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFF1F4F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1844),
        automaticallyImplyLeading: false,
        leading: ElevatedButton(
          onPressed: () {
            print('back button pressed');
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: const Color(0xFF1C1844),
              fixedSize: const Size(50,50)
          ),
          child: const Icon(Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,),
        ),
        title: const Text(
          'Find Doctor, Diagonistics report',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            children: [
              Container(
                width: 100,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFFF1F4F8),
                  shape: BoxShape.rectangle,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                      child: Image.network(
                        'https://i.imgur.com/RCkfCKO.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF1F4F8),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(70, 0, 0, 0),
                      child: Image.network(
                        'https://i.imgur.com/NA3QN0o.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(25, 25, 25, 25),
                child: Text(
                  'Book an appointment with the best surgeons for your health needs',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Container(
                  width: 100,
                  height: 1000,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF1F4F8),
                  ),
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                          const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),

                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: const Text("Select Ailment",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                )
                            ),
                            value: dropDownValue,
                            items: options.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                dropDownValue = value!;
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
                        Padding(
                          padding:
                          const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                          child: TextFormField(
                            controller: textController1,
                            obscureText: false,
                            decoration: const InputDecoration(
                              hintText: 'Name*',
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF57636C),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFF1F4F8),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFF1F4F8),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 10, 10),
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
                          padding:
                          const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                          child: TextFormField(
                            controller: textController2,
                            obscureText: false,
                            decoration: const InputDecoration(
                              hintText: 'Contact Number*',
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF57636C),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              contentPadding:
                              EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            ),
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF101213),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        // const Align(
                        //   alignment: AlignmentDirectional(-1, -0.05),
                        //   child: Padding(
                        //     padding:
                        //     EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        //     child: Text(
                        //       'CHOOSE YOUR CITY',
                        //       style: TextStyle(
                        //         fontFamily: 'Poppins',
                        //         color: Color(0xFF101213),
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // Row(
                        //   mainAxisSize: MainAxisSize.max,
                        //   children: [
                        //     Align(
                        //       alignment: AlignmentDirectional(-0.95, 0),
                        //       child: FlutterFlowRadioButton(
                        //         options: ['Dehradun'].toList(),
                        //         onChanged: (val) =>
                        //             setState(() => radioButtonValue = val),
                        //         optionHeight: 25,
                        //         textStyle: FlutterFlowTheme.of(context)
                        //             .bodyText1
                        //             .override(
                        //           fontFamily: 'Poppins',
                        //           color: Colors.black,
                        //         ),
                        //         buttonPosition: RadioButtonPosition.left,
                        //         direction: Axis.vertical,
                        //         radioButtonColor: Colors.blue,
                        //         inactiveRadioButtonColor: Color(0x8A000000),
                        //         toggleable: false,
                        //         horizontalAlignment: WrapAlignment.start,
                        //         verticalAlignment: WrapCrossAlignment.start,
                        //       ),
                        //     ),
                        //     Padding(
                        //       padding:
                        //       EdgeInsetsDirectional.fromSTEB(200, 0, 0, 0),
                        //       child: Text(
                        //         'Change',
                        //         style: FlutterFlowTheme.of(context)
                        //             .bodyText1
                        //             .override(
                        //           fontFamily: 'Poppins',
                        //           color: FlutterFlowTheme.of(context)
                        //               .primaryColor,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Padding(
                          padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                          child: ElevatedButton(
                            onPressed: (){
                              print("i pressed hehe");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF282164),
                              fixedSize: const Size(175, 50),
                              shape: const StadiumBorder(),
                            ),
                            child: const Text(
                              "Book Appointment",
                              style:TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFFF1F4F8),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // child: FFButtonWidget(
                          //   onPressed: () {
                          //     print('Button pressed ...');
                          //   },
                          //   text: 'Book Appointment',
                          //   options: FFButtonOptions(
                          //     width: double.infinity,
                          //     height: 40,
                          //     color: Color(0xFF282164),
                          //     textStyle: FlutterFlowTheme.of(context)
                          //         .subtitle2
                          //         .override(
                          //       fontFamily: 'Poppins',
                          //       color: Colors.white,
                          //     ),
                          //     borderSide: BorderSide(
                          //       color: Colors.transparent,
                          //       width: 1,
                          //     ),
                          //     borderRadius: BorderRadius.circular(8),
                          //   ),
                          // ),
                        ),
                        const Text(
                          'By submitting this form, you agree to HCS\'s',
                          style:TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF101213),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        InkWell(
                          onTap: () async {},
                          child: const Text(
                            'T&C',
                            style:TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF4B39EF),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
