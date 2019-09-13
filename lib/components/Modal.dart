import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:gymtrackerandroid/bloc/User.dart';
import 'package:gymtrackerandroid/helper/Text.dart';
import 'package:provider/provider.dart';

class Modal extends StatefulWidget {
  final int reps;
  final int weight;
  final String subexercise;
  final String mainexercise;
  const Modal(
      {Key key,
      this.reps = 0,
      this.weight = 0,
      this.subexercise,
      this.mainexercise})
      : super(key: key);
  @override
  _ModalState createState() => _ModalState();
}

class _ModalState extends State<Modal> {
  String currentValue;
  var _key = GlobalKey<FormState>();
  var _name = TextEditingController();
  var _reps = TextEditingController();
  var _weight = TextEditingController();

  @override
  void initState() {
    super.initState();
    _reps.text = widget.reps.toString();
    _weight.text = widget.weight.toString();
    _name.text = widget.subexercise;
    currentValue = widget.mainexercise;
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserBloc>(context);
    List<DropdownMenuItem> items() {
      List<DropdownMenuItem> temp = List<DropdownMenuItem>();
      user.allExercises.forEach((item) {
        temp.add(DropdownMenuItem(
          value: item.main,
          child: Text(capitalizeFirstLetter(item.main)),
        ));
      });

      return temp;
    }

    return AlertDialog(
        title: Text("Add Exercise"),
        actions: <Widget>[
          FlatButton(
            child: const Text("Done"),
            onPressed: () async {
              if (_key.currentState.validate()) {
                Navigator.pop(context);
                user.setLoadingState(true);
                var mydb = Firestore.instance;
                var newData = await mydb
                    .collection(user.user.uid)
                    .document(currentValue)
                    .get();
                var data = newData.data;
                data[_name.value.text] = {
                  "weight": int.parse(_weight.value.text),
                  "reps": int.parse(_reps.value.text),
                };
                await mydb
                    .collection(user.user.uid)
                    .document(currentValue)
                    .setData(data);
                user.setLoadingState(false);
              }
            },
          ),
          FlatButton(
            child: Text("Cancel", style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        content: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DropdownButton(
                  hint: Text("Select Body Part"),
                  items: items(),
                  onChanged: (val) {
                    setState(() {
                      currentValue = val;
                    });
                  },
                  value: currentValue,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Exercise Name"),
                  controller: _name,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "This Field cannot be empty";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Reps"),
                  controller: _reps,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value.isEmpty) {
                      return "This Field cannot be empty";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Weight"),
                  controller: _weight,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value.isEmpty) {
                      return "This Field cannot be empty";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
