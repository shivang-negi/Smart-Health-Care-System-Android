import 'package:app/homepage.dart';
import 'package:app/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CheckUserSignIn.dart';
import 'BookAppointment.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  var number = prefs.getString('Phone_Number');
  if(number==null) {
    runApp(MaterialApp(home: LoginFirst()));
  } else {
    runApp(MaterialApp(home: HomePageWidget(number: number)));
  }
  // runApp(MaterialApp(home: ProfilePage(name: 'shivang',age: 1, city: 'city',state: 'state',profile: "https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg",number: '955',email: 'shi@shi',)));
}