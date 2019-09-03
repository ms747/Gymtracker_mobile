import 'package:flutter/material.dart';
import 'package:gymtrackerandroid/bloc/User.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Consumer<UserBloc>(
              builder: (BuildContext context, UserBloc value, Widget child) {
                return Text(
                    "Loggedin State ${value.getloggedInStatus.toString()}");
              },
            )
          ],
        ),
      ),
    );
  }
}
