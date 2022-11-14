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
        backgroundColor: const Color(0xFFF1F4F8),
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.network(
                                        'https://media.istockphoto.com/id/1305963775/vector/male-doctor-is-checking-medical-history-of-a-patient.jpg?s=612x612&w=0&k=20&c=QCzklF30ugWO-t7LVF0tJ5j-Gk4RlZIISeZ3-6Jlzik=',
                                        width: double.infinity,
                                        height: 180,
                                        fit: BoxFit.fill,
                                      ),
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
                                    child: Image.network(
                                      'https://t1.thpservices.com/previewimage/gallil/f3b8fe2d72c92e4e468cefb96e0a9c57/esy-057855656.jpg',
                                      fit: BoxFit.fill,
                                    ),
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
                                      child: Image.network(
                                        'https://i.ytimg.com/vi/zi4thNp15qg/hqdefault.jpg',
                                        fit: BoxFit.fill,
                                      ),
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
                                alignment: AlignmentDirectional(0, 0),
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
                                      child: Image.network(
                                        'https://img.freepik.com/premium-vector/cartoon-girl-anime-style-sports-uniform-shorts-tshirt-vector-art-toddler-character_456865-1280.jpg?w=2000',
                                        fit: BoxFit.fill,
                                      ),
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
                                      child: Image.network(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAOZIC6mWlKV_Z6cGPOITSjK4tKVNtDmlKXA&usqp=CAU',
                                        fit: BoxFit.fill,
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
                                        child: Image.network(
                                          'https://images.saymedia-content.com/.image/t_share/MTc0MTY5OTE0NTYxODAwMDYw/how-to-draw-a-cartoon-eye.jpg',
                                          fit: BoxFit.fill,
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
                                          child: Image.network(
                                            'https://media.istockphoto.com/id/1125874619/vector/human-heart-with-arteries-and-valves-vector-cartoon-illustration-of-anatomy-internal-organ.jpg?s=612x612&w=0&k=20&c=z0o-Vr-_gq_MBSwvMdgal8zZBo7GmNf6htrZ-BBnx8M=',
                                            fit: BoxFit.fill,
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
                                          child: Image.network(
                                            'https://image.shutterstock.com/image-vector/young-teenager-woman-suffering-migraine-260nw-1490258219.jpg',
                                            fit: BoxFit.fill,
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
                                          child: Image.network(
                                            'https://us.123rf.com/450wm/jemastock/jemastock2004/jemastock200409457/144571156-man-sick-with-chest-pain-covid19-symptom-vector-illustration-design.jpg?ver=6',
                                            fit: BoxFit.fill,
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