import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserBloc extends ChangeNotifier{
  FirebaseUser _user;
  bool _loggedInStatus = false;

  bool get getloggedInStatus => _loggedInStatus;

  set setloggedInStatus(bool loggedInStatus) {
    _loggedInStatus = loggedInStatus;
  }

  FirebaseUser get getuser =>  _user;

  set setuser(FirebaseUser user) {
    _user = user;
    notifyListeners();
  }

  

}

UserBloc userBloc = new UserBloc();