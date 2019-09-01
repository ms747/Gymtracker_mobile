import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymtrackerandroid/bloc/bloc.dart';
import 'package:gymtrackerandroid/bloc/exercise_bloc.dart';
import 'package:gymtrackerandroid/bloc/exercise_state.dart';
import 'package:gymtrackerandroid/pages/Login.dart';

import 'components/Accordian.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final _exerciseBloc = ExerciseBloc();
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
                        child: Text(
                          "Welcome, Mayur Shah",
                          style: Theme.of(_key.currentContext).textTheme.title,
                        ),
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
                    Navigator.pushReplacement(_key.currentContext,
                        MaterialPageRoute(builder: (ctx) => LoginPage()));
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

  @override
  Widget build(BuildContext context) {
    _exerciseBloc.dispatch(AppStarted());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym Tracker',
      home: Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text('🏋 Gym Tracker'),
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
        body: BlocBuilder<ExerciseBloc, ExerciseState>(
          builder: (ctx, data) {
            return Center(
              child: Container(
                child: _ListView(),
              ),
            );
          },
          bloc: _exerciseBloc,
        ),
      ),
    );
  }
}

class _ListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: false,
      children: <Widget>[
        MyAccordian(),
        MyAccordian(),
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final double radius;
  Avatar({@required this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: this.radius,
      backgroundImage: NetworkImage(
        "https://lh4.googleusercontent.com/-5kR9LOpxYqA/AAAAAAAAAAI/AAAAAAAABFU/ihjSdIP-dss/photo.jpg",
      ),
    );
  }
}
