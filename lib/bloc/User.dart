import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserBloc extends ChangeNotifier {
  bool loggedin = false;
  FirebaseUser user;

  void changeLogin(bool status){
    loggedin = status;
    notifyListeners();
  }

  void setUser(FirebaseUser _user){
    user = _user;
    notifyListeners();
  }
}


