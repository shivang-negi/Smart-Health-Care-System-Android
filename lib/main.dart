import 'package:app/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  var number = prefs.getString('Phone_Number');
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  if(number==null) {
    runApp(MaterialApp(home: LoginFirst()));
  } else {
    runApp(MaterialApp(home: HomePageWidget(number: number)));
  }
}

