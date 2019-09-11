import 'package:flutter/material.dart';

class DirectionBloc extends ChangeNotifier{
  bool visible = true;

  void setVisibility(bool status){
    this.visible = status;
    notifyListeners();
  }
}