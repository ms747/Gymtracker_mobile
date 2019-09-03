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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Gym Tracker",
            style: Theme.of(context).textTheme.display1,
          ),
          RaisedButton(
            color: Colors.white70,
            child: Text("Sign in With Google"),
            onPressed: () async {
              // Navigator.pushNamed(context, "/admin");
              await login();
              isUserLoggedIn(context);
            },
          ),
        ],
      ),
    );
  }

  void isUserLoggedIn(BuildContext context) {
    isLoggedIn().then((bool loggedIn) {
      if (loggedIn) {
        widget.user.changeLogin(true);
        Navigator.pushReplacementNamed(context, "/admin");
      }
    });
  }
}
