import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymtrackerandroid/interfaces/Exercise.dart';

class UserBloc extends ChangeNotifier {
  bool loggedin = false;
  FirebaseUser user;
  List<Exercise> allExercises;
  bool loading = false;
  
  void changeLogin(bool status){
    loggedin = status;
    notifyListeners();
  }

  void setUser(FirebaseUser _user){
    user = _user;
    notifyListeners();
  }

  void setAllExcercises(List<Exercise> list){
    this.allExercises = list;
  }
  
  void setLoadingState(bool state){
    this.loading = state;
    notifyListeners();
  }

}


