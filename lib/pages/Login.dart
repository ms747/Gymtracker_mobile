import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymtrackerandroid/bloc/bloc.dart';
import 'package:gymtrackerandroid/bloc/exercise_bloc.dart';
import 'package:gymtrackerandroid/bloc/exercise_state.dart';
import 'package:gymtrackerandroid/main.dart';

class LoginPage extends StatelessWidget {
  final _exerciseBloc = ExerciseBloc();
  final _key = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
          key: _key,
          body: BlocBuilder<ExerciseBloc, ExerciseState>(
            bloc: _exerciseBloc,
            builder: (ctx, data) {
              return Center(
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                      onPressed: () {
                        _exerciseBloc.dispatch(GoogleLogin());
                        Navigator.pushReplacement(_key.currentContext,
                            MaterialPageRoute(builder: (ctx) => MyApp()));
                      },
                      color: Colors.red,
                      child: Text(
                        "Login with Google",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
