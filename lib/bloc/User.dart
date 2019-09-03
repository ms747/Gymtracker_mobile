import 'package:flutter/material.dart';

class UserBloc extends ChangeNotifier {
  bool loggedin = false;

  void changeLogin(bool status){
    loggedin = status;
    notifyListeners();
  }
}


