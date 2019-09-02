import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gymtrackerandroid/bloc/User.dart';
import 'package:gymtrackerandroid/main.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Future(() {
      checkLoggedIn();
    });
  }

  void checkLoggedIn() async {
    var user = await FirebaseAuth.instance.currentUser();
    final userState = Provider.of<UserBloc>(_key.currentContext);
    if (user != null) {
      userState.setloggedInStatus = true;
      userState.setuser = user;
      Navigator.of(_key.currentContext)
          .push(MaterialPageRoute(builder: (ctx) => MyApp()));
    } else {
      userState.setloggedInStatus = false;
    }
  }

  void login() async {
    final _googleSignIn = GoogleSignIn();
    final _auth = FirebaseAuth.instance;
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    var user = (await _auth.signInWithCredential(credential)).user;
    checkLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: ChangeNotifierProvider.value(
        child: Scaffold(
            key: _key,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Gym Tracker",
                    style: TextStyle(fontSize: 38),
                  ),
                  Text(
                    "🏋",
                    style: TextStyle(fontSize: 96),
                  ),
                  RaisedButton(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    onPressed: () {
                      login();
                    },
                    color: Colors.red,
                    child: Text(
                      "Login with Google",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            )),
        value: userBloc,
      ),
    );
  }
}
