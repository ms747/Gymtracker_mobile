import 'package:flutter/material.dart';
import 'package:gymtrackerandroid/bloc/User.dart';
import 'package:gymtrackerandroid/pages/Admin.dart';
import 'package:gymtrackerandroid/pages/Login.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
        builder: (BuildContext context) => UserBloc(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/',
      routes: {
        "/": (context) => LoginPage(),
        "/admin": (context) => AdminPage()
      },
    );
  }
}
