import 'package:app/Medicine.dart';
import 'package:app/Symptoms.dart';
import 'package:flutter/material.dart';

class SearchOptions extends StatelessWidget {
  final String number;
  const SearchOptions({Key? key, required this.number}) : super(key: key);

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
            child: Text(
              "What are you looking for?",
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: Color(0xFF000000),
              ),
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
                      const Icon(Icons.search,
                        color: Colors.black54,
                        size: 24,),
                      const Text("Online Expert Consultation",
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
                              'assets/images/doctor.png',
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Symptoms(number: number)));
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
                      const Icon(Icons.search,
                        color: Colors.black54,
                        size: 24,),
                      const Text("Medicines & Essentials",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      Padding(padding: const EdgeInsetsDirectional.fromSTEB(3, 2, 0, 0),
                          child: Container(
                            width: 75,
                            height: 75,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),

                            child: Image.asset(
                                'assets/images/med.png',
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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MedicinePage(number: number)));
                        },
                      )
                  ),
                ],
              )
          )
        ],
      ),
    );
  }
}
