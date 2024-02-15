import './screens/login_page.dart';
import 'package:flutter/material.dart';

import 'screens/home_page.dart';

import 'screens/login_page.dart';

import 'package:firebase_core/firebase_core.dart';
 
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Map App',
      routes: {
        '/login':(context) => LoginPage(),
        '/homee':(context) => HomePage(),
      },
      home: LoginPage(),
    );
  }
}