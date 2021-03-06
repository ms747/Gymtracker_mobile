import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gymtrackerandroid/bloc/Direction.dart';
import 'package:gymtrackerandroid/components/Modal.dart';
import 'package:gymtrackerandroid/helper/Text.dart';
import 'package:gymtrackerandroid/interfaces/Exercise.dart';
import 'package:provider/provider.dart';

import '../bloc/User.dart';

class FirestoreData extends StatefulWidget {
  final DirectionBloc directionBloc;
  FirestoreData(this.directionBloc);
  @override
  _FirestoreDataState createState() => _FirestoreDataState();
}

class _FirestoreDataState extends State<FirestoreData> {
  var _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (widget.directionBloc.visible) {
          widget.directionBloc.setVisibility(false);
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!widget.directionBloc.visible) {
          widget.directionBloc.setVisibility(true);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserBloc>(context);
    return StreamBuilder(
      stream: Firestore.instance.collection(user.user.uid).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return CircularProgressIndicator();
        }

        List<Exercise> list = List<Exercise>();
        snapshot.data.documents.forEach((DocumentSnapshot data) {
          Exercise temp = Exercise();
          var exercises = data.data;
          if (exercises.keys.length != 0) {
            temp.setMain(data.documentID);
            for (var exercise in exercises.keys) {
              temp.addSub(exercise);
              temp.setInfo(
                newReps: exercises[exercise]["reps"],
                newWeight: exercises[exercise]["weight"],
              );
            }
            list.add(temp);
          }
        });

        user.setAllExcercises(list);

        return ListView.builder(
          itemCount: user.allExercises.length,
          controller: _scrollController,
          itemBuilder: (_, i) {
            return Card(
              elevation: 4,
              margin: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildTitle(user.allExercises, i),
                  ...buildSubexercise(user.allExercises, i, user, context)
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildTitle(List<Exercise> list, int i) => Padding(
        padding: const EdgeInsets.only(left: 12, top: 8),
        child: Text(
          "${list[i].main.toUpperCase()}",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      );

  Iterable<ListTile> buildSubexercise(
      List<Exercise> list, int i, UserBloc user, BuildContext context) {
    return list[i].sub.asMap().map((a, d) {
      return MapEntry(
        a,
        ListTile(
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              showGeneralDialog(
                  transitionDuration: Duration(milliseconds: 500),
                  context: context,
                  barrierDismissible: true,
                  barrierColor: Colors.black.withOpacity(0.5),
                  barrierLabel: '',
                  transitionBuilder: (context, a1, a2, widget) {
                    final curvedValue = Curves.fastOutSlowIn.transform(a1.value) -   1.0;
                    return Transform(
                      child: widget,
                      transform: Matrix4.translationValues(0, 500*curvedValue, 0),
                    );
                  },
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return Modal(
                      reps: list[i].info[a].reps,
                      weight: list[i].info[a].weight,
                      subexercise: d,
                      mainexercise: list[i].main,
                    );
                  });
            },
          ),
          title: Text(capitalizeFirstLetter(d)),
          subtitle: Text(
              "Reps : ${list[i].info[a].reps} Weight : ${list[i].info[a].weight} kg"),
        ),
      );
    }).values;
  }
}
