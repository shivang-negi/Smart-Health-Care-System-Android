import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  final String number;
  const Orders({Key? key, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: const Text(
            'Orders',
            style: TextStyle(
                fontFamily: 'Lexend',
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600
            ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 0,
        ),
        body: const Center(
          child: Text(
            "You have no orders.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 17
            ),
          ),
        )
    );
  }
}

class Records extends StatelessWidget {
  final String number;
  const Records({Key? key, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: const Text(
            'Medical Records',
            style: TextStyle(
                fontFamily: 'Lexend',
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600
            ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 0,
        ),
        body: const Center(
          child: Text(
            "No medical records present.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 17
            ),
          ),
        )
    );
  }
}