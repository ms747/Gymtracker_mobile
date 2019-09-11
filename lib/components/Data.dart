import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymtrackerandroid/components/Modal.dart';
import 'package:gymtrackerandroid/helper/Text.dart';
import 'package:gymtrackerandroid/interfaces/Exercise.dart';
import 'package:provider/provider.dart';
import '../bloc/User.dart';

class FirestoreData extends StatelessWidget {
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
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return Modal(
                      reps: 12,
                      weight: 90,
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
