import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MaterialApp(home: HomePageWidget()));
}

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
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
        backgroundColor: const Color(0xFFFFFFFF),
        endDrawer: const Drawer(
          elevation: 16,
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xFF050212),
          automaticallyImplyLeading: false,
          leading: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    print('icon pressed');
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
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                child: SelectionArea(
                    child: Text(
                      'Place, Dehradun',
                      style:
                          TextStyle(
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
                          // borderColor: Colors.transparent,
                          // borderRadius: 30,
                          // borderWidth: 1,
                          // buttonSize: 60,
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
                              autofocus: true,
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
                                      child: Image.network(
                                        'https://media.istockphoto.com/id/1208368866/vector/daily-skin-care-vector-illustration-line-style.jpg?s=612x612&w=0&k=20&c=1qAzu7hfs5oTjPRfRpHSJ9XiPTjFJ_K-bVhOEMbWd5o=',
                                      ),
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
                                      child: Image.network(
                                        'https://i.pinimg.com/564x/80/0c/a3/800ca3d3d1c4c4241f2b920d1eda6897.jpg',
                                      ),
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
                                      child: Image.network(
                                        'https://www.creativehatti.com/wp-content/uploads/2021/08/Heart-is-with-the-stethoscope-illustration-15-small.jpg',
                                      ),
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
                                    // child: FlutterFlowIconButton(
                                    //   borderColor: Color(0xFFF8F2F2),
                                    //   borderRadius: 90,
                                    //   borderWidth: 1,
                                    //   buttonSize: 60,
                                    //   icon: Icon(
                                    //     Icons.add,
                                    //     color: Color(0xFFF8F2F2),
                                    //     size: 30,
                                    //   ),
                                    //   onPressed: () {
                                    //     print('IconButton pressed ...');
                                    //   },
                                    // ),
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
                                        15, 15, 0, 0),
                                    child: SelectionArea(
                                        child: Text(
                                          'Cardiologist',
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
                                        15, 15, 0, 0),
                                    child: SelectionArea(
                                        child: Text(
                                          'More',
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
                              print('works???');
                              },
                          ),
                        ),
                        // OutlinedButton(onPressed: () {
                        //       print('blue button pressed ...');
                        //     },
                        //     child: Text(''),
                        //     style: OutlinedButton.styleFrom(
                        //       minimumSize: Size.fromHeight(double.infinity),
                        //     ),
                        // ),
                        // FFButtonWidget(
                        //   onPressed: () {
                        //     print('Button pressed ...');
                        //   },
                        //   text: '',
                        //   options: FFButtonOptions(
                        //     width: double.infinity,
                        //     height: double.infinity,
                        //     color: Color(0x004B39EF),
                        //     textStyle:
                        //     FlutterFlowTheme.of(context).subtitle2.override(
                        //       fontFamily: 'Poppins',
                        //       color: Colors.white,
                        //     ),
                        //     borderSide: BorderSide(
                        //       color: Colors.transparent,
                        //       width: 1,
                        //     ),
                        //     borderRadius: BorderRadius.circular(30),
                        //   ),
                        // ),
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
                                  child: Image.network(
                                    'https://static.independent.co.uk/s3fs-public/thumbnails/image/2019/01/23/11/video-doctor-230119.jpg?quality=75&width=982&height=726&auto=webp',
                                    width: 165,
                                    height: 160,
                                    fit: BoxFit.cover,
                                  ),
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
                                print('works111???');
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
                                  child: Image.network(
                                    'https://media.istockphoto.com/id/1300036753/photo/falling-antibiotics-healthcare-background.jpg?s=612x612&w=0&k=20&c=oquxJiLqE33ePw2qML9UtKJgyYUqjkLFwxT84Pr-WPk=',
                                    width: 165,
                                    height: 160,
                                    fit: BoxFit.cover,
                                  ),
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
                                        // style: FlutterFlowTheme.of(context).bodyText1.override(
                                        //   fontFamily: 'Poppins',
                                        //   color: Color(0xFF808386),
                                        //   fontSize: 10,
                                        // ),
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
                )

              ],
            ),
          ),
        ),
      );
  }
}