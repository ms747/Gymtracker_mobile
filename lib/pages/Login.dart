import 'package:flutter/material.dart';
import 'package:gymtrackerandroid/bloc/User.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserBloc>(context);
    return Container(
        child: Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text("Login Page"),
          onPressed: () {
            user.setloggedInStatus = true;
            Navigator.pushNamed(context, "/admin");
          },
        ),
      ),
    ));
  }
}
