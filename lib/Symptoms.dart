import 'package:flutter/material.dart';

class Symptoms extends StatefulWidget {
  final String number;
  Symptoms({Key? key, required this.number}) : super(key: key);

  @override
  State<Symptoms> createState() => _SymptomsState();
}

class _SymptomsState extends State<Symptoms> {
  TextEditingController? searchController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
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
          'Consult a Doctor',
          style: TextStyle(
            fontFamily: 'Lexend',
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [],
        centerTitle: false,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        children: [
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(22, 17, 10, 10),
            child: Text(
              'Search Health Problems / Symptoms',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Color(0xFF133A4D),
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: Container(
              width: 100,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFF2EAEA),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        print("searched");
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: const Color(0xFFF2EAEA),
                          fixedSize: const Size(50,50),
                          shadowColor: const Color(0xFFF2EAEA),
                      ),
                      child: const Icon(Icons.search,
                        color: Colors.black,
                        size: 30,),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: TextFormField(
                        controller: searchController,
                        autofocus: false,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Eg. cold, cough, fever etc',
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
                          fillColor: const Color(0xFFF2EAEA),
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(22, 17, 10, 0),
            child: Text(
              'How video consultation works?',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Color(0xFF133A4D),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
            child: SizedBox(
              width: 100,
              height: 102,
              // decoration: BoxDecoration(
              //   color: ,
              // ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/images/symp/1.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Text(
                        'Select a\nspeciality',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.navigate_next,
                    color: Colors.black,
                    size: 28,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/images/symp/2.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Text(
                        'Complete\npayment',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.navigate_next,
                    color: Colors.black,
                    size: 28,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/images/symp/3.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Text(
                        'Start your\nconsultation',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 18, 0, 0),
            child: SizedBox(
              width: 100,
              height: 383,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(17, 10, 0, 1),
                    child: Text(
                      'Top Specialities',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFF133A4D),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 100,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                      'assets/images/symp/4.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const Text(
                                    'General\nphysician',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                  ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 100,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                      'assets/images/symp/5.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const Text(
                                    'Derma\ntologist',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 100,
                          // decoration: BoxDecoration(
                          //   color: FlutterFlowTheme.of(context)
                          //       .secondaryBackground,
                          // ),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),child: Image.asset(
                                    'assets/images/symp/6.png',
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                  const Text(
                                    'Ortho\npedic',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 100,
                          // decoration: BoxDecoration(
                          //   color: FlutterFlowTheme.of(context)
                          //       .secondaryBackground,
                          // ),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),child: Image.asset(
                                    'assets/images/symp/7.png',
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                  const Text(
                                    'Pediatric',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 100,
                          // decoration: BoxDecoration(
                          //   color: FlutterFlowTheme.of(context)
                          //       .secondaryBackground,
                          // ),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),child: Image.asset(
                                    'assets/images/symp/8.png',
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                  const Text(
                                    'Gynec\nologist',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 100,
                          // decoration: BoxDecoration(
                          //   color: FlutterFlowTheme.of(context)
                          //       .secondaryBackground,
                          // ),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),child: Image.asset(
                                    'assets/images/symp/9.png',
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                  const Text(
                                    'Psychiatry',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 100,
                          // decoration: BoxDecoration(
                          //   color: FlutterFlowTheme.of(context)
                          //       .secondaryBackground,
                          // ),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),child: Image.asset(
                                    'assets/images/symp/10.png',
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                  const Text(
                                    'Urology',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 100,
                          // decoration: BoxDecoration(
                          //   color: FlutterFlowTheme.of(context)
                          //       .secondaryBackground,
                          // ),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),child: Image.asset(
                                    'assets/images/symp/11.png',
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                  const Text(
                                    'Cardiology',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 100,
                          // decoration: BoxDecoration(
                          //   color: FlutterFlowTheme.of(context)
                          //       .secondaryBackground,
                          // ),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),child: Image.asset(
                                    'assets/images/symp/12.png',
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                  const Text(
                                    'Dental',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 100,
                          // decoration: BoxDecoration(
                          //   color: FlutterFlowTheme.of(context)
                          //       .secondaryBackground,
                          // ),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),child: Image.asset(
                                    'assets/images/symp/13.png',
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                  const Text(
                                    'Eye care',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 100,
                          // decoration: BoxDecoration(
                          //   color: FlutterFlowTheme.of(context)
                          //       .secondaryBackground,
                          // ),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),child: Image.asset(
                                    'assets/images/symp/14.png',
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                  const Text(
                                    'Pulmono\nlogy',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 100,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),child: Image.asset(
                                    'assets/images/symp/15.png',
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                  const Text(
                                    'Gastroente\nrology',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:  const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
            child: SizedBox(
              width: 100,
              height: 540,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(17, 10, 0, 1),
                    child: Text(
                      'Common Health Conditions',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFF133A4D),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 100,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),child: Image.asset(
                                    'assets/images/symp/16.png',
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                  const Text(
                                    'Acidity',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 100,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),child: Image.asset(
                                    'assets/images/symp/17.png',
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                  const Text(
                                    'Consti\npation',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 100,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),child: Image.asset(
                                    'assets/images/symp/18.png',
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                  const Text(
                                    'Obesity',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 100,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),child: Image.asset(
                                    'assets/images/symp/19.png',
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                  const Text(
                                    'Back Pain',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 100,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),child: Image.asset(
                                    'assets/images/symp/20.png',
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                  const Text(
                                    'Head\nAche',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 100,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),child: Image.asset(
                                    'assets/images/symp/21.png',
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                  const Text(
                                    'Depress\nion',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 100,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),child: Image.asset(
                                    'assets/images/symp/22.png',
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                  const Text(
                                    'Cramps',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 100,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),child: Image.asset(
                                    'assets/images/symp/23.png',
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                  const Text(
                                    'Hairfall',style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 100,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),child: Image.asset(
                                    'assets/images/symp/24.png',
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                  const Text(
                                    'Sore\nThroat',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 100,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),child: Image.asset(
                                    'assets/images/symp/25.png',
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                  const Text(
                                    'Vaginal\nDischarge',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 100,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),child: Image.asset(
                                    'assets/images/symp/26.png',
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                  const Text(
                                    'Autism',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 100,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),child: Image.asset(
                                    'assets/images/symp/27.png',
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                  const Text(
                                    'Bad\nVision',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 100,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),child: Image.asset(
                                    'assets/images/symp/28.png',
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                  const Text(
                                    'UTI',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 100,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),child: Image.asset(
                                    'assets/images/symp/29.png',
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                  const Text(
                                    'Diabetes',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 100,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),child: Image.asset(
                                    'assets/images/symp/30.png',
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                  const Text(
                                    'Vitiligo',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 100,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),child: Image.asset(
                                    'assets/images/symp/31.png',
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                  const Text(
                                    'High\nBlood \nPressure',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                                    print('button works');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ]
      ),
    );
  }
}
