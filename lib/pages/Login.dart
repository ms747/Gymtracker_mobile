import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymtrackerandroid/bloc/User.dart';
import 'package:gymtrackerandroid/helper/Auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserBloc>(context);
    return Container(
      child: Scaffold(
        body: BuildLoginPage(user: user),
      ),
    );
  }
}

class BuildLoginPage extends StatefulWidget {
  const BuildLoginPage({
    Key key,
    @required this.user,
  }) : super(key: key);

  final UserBloc user;

  @override
  _BuildLoginPageState createState() => _BuildLoginPageState();
}

class _BuildLoginPageState extends State<BuildLoginPage> {
  @override
  void initState() {
    super.initState();
    isUserLoggedIn(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1.0,
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildText(context),
          buildRaisedButton(context),
        ],
      ),
    );
  }

  Widget buildRaisedButton(BuildContext context) {
    return RaisedButton(
      color: Colors.red,
      textColor: Colors.white,
      child: Text("Sign in With Google"),
      onPressed: () async {
        await login();
        isUserLoggedIn(context);
      },
    );
  }

  Widget buildText(BuildContext context) {
    return Text(
      "Gym Tracker",
      style: Theme.of(context).textTheme.display1,
    );
  }

  void isUserLoggedIn(BuildContext context) {
    isLoggedIn().then((FirebaseUser _user) {
      if (_user != null) {
        widget.user.setUser(_user);
        Navigator.pushReplacementNamed(context, "/admin");
      }
    });
  }
}
