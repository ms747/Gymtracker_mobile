import 'package:flutter/material.dart';
import 'package:gymtrackerandroid/bloc/User.dart';
import 'package:gymtrackerandroid/helper/Auth.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserBloc>(context);
    return Scaffold(
      appBar: buildAppBar(user,context),
      body: buildBody(user, context),
    );
  }

  Widget buildAppBar(UserBloc user, BuildContext context) {
    return AppBar(
      title: Text("Admin Page"),
      actions: <Widget>[
        buildProfileIcon(user,context)
      ],
    );
  }

  Widget buildProfileIcon(UserBloc user, BuildContext context) {
    return InkWell(
        onTap: (){
          doLogout(user,context);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(user.user.photoUrl),
          ),
        ),
      );
  }

  Widget buildBody(UserBloc user, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Consumer<UserBloc>(
            builder: (BuildContext context, UserBloc value, Widget child) {
              return Text("Logged in as, ${value.user.displayName.toString()}");
            },
          ),
          RaisedButton(
            onPressed: () {
              doLogout(user, context);
            },
            child: Text("Logout"),
          )
        ],
      ),
    );
  }

  void doLogout(UserBloc user, BuildContext context) {
    logout().then((_) {
      user.changeLogin(null);
      Navigator.pushReplacementNamed(context, "/");
    });
  }
}
