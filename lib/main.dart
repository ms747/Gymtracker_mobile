import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymtrackerandroid/bloc/User.dart';
import 'package:gymtrackerandroid/pages/Login.dart';
import 'package:provider/provider.dart';

import 'components/Accordian.dart';

void main() => runApp(LoginPage());

class MyApp extends StatelessWidget {
  final _key = new GlobalKey<ScaffoldState>();

  void _showBottomMenu() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        context: _key.currentContext,
        builder: (_) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
              ),
            ),
            child: Column(
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: _buildtext(),
                      ),
                      Avatar(
                        radius: 60,
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                  indent: 30,
                  endIndent: 30,
                ),
                ListTile(
                  leading: Icon(Icons.lock),
                  title: Text("Logout"),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Future(() {
                      Navigator.pushReplacement(_key.currentContext,
                          MaterialPageRoute(builder: (ctx) => LoginPage()));
                    });
                  },
                ),
                Divider(
                  color: Colors.black,
                  indent: 30.0,
                  endIndent: 30.0,
                ),
              ],
            ),
          );
        });
  }

  Text _buildtext() {
    return Text(
      "Welcome, ${userBloc.getuser.displayName}",
      style: Theme.of(_key.currentContext).textTheme.title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym Tracker',
      home: ChangeNotifierProvider.value(
              child: Scaffold(
          key: _key,
          appBar: AppBar(
            title: Text('Gym Tracker'),
            actions: <Widget>[
              FlatButton(
                child: Avatar(
                  radius: 20,
                ),
                onPressed: () {
                  _showBottomMenu();
                },
              ),
            ],
          ),
          body: Center(
            child: Container(
              child: _listView(),
            ),
          ),
        ), value: userBloc,
      ),
    );
  }
}

Widget _listView() {
  return ListView(
    primary: false,
    children: <Widget>[
      MyAccordian(),
      MyAccordian(),
    ],
  );
}

class Avatar extends StatelessWidget {
  final double radius;
  Avatar({@required this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: this.radius,
      backgroundImage: NetworkImage(
        userBloc.getuser.photoUrl,
      ),
    );
  }
}
