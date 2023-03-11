import 'package:app/homepage.dart';
import 'package:app/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BookAppointment.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile.dart';
import 'Symptoms.dart';
import 'Doctor/physician.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  var number = prefs.getString('Phone_Number');
  await Future.delayed(const Duration(seconds: 1));
  if(number==null) {
    runApp(MaterialApp(home: LoginFirst()));
  } else {
    runApp(MaterialApp(home: HomePageWidget(number: number)));
  }
  // runApp(const MaterialApp(home: PhysicianWidget()));
}

