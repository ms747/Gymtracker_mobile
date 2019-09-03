import 'package:flutter/material.dart';
import 'package:gymtrackerandroid/pages/Admin.dart';
import 'package:gymtrackerandroid/pages/Login.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: '/',
      routes: {
        "/": (context) => LoginPage(),
        "/admin" : (context) => AdminPage()
      },
    );
  }
}