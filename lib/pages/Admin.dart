import 'package:flutter/material.dart';
import 'package:gymtrackerandroid/bloc/User.dart';
import 'package:gymtrackerandroid/helper/Auth.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserBloc>(context);
    return Scaffold(
      appBar: buildAppBar(user),
      body: buildCenter(user,context),
    );
  }

  AppBar buildAppBar(UserBloc user) {
    return AppBar(
      title: Text("Admin Logged in ${user.loggedin}"),
    );
  }

  Widget buildCenter(UserBloc user,BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Consumer<UserBloc>(
            builder: (BuildContext context, UserBloc value, Widget child) {
              return Text("Loggedin State ${value.loggedin.toString()}");
            },
          ),
          RaisedButton(
            onPressed: () {
              logout().then((_){
                user.changeLogin(false);
                Navigator.pushReplacementNamed(context, "/");
              });
            },
            child: Text("Logout"),
          )
        ],
      ),
    );
  }
}
