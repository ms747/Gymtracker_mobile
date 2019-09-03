import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
        if (!snapshot.hasData) {
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
                  newWeight: exercises[exercise]["weight"]);
            }
            list.add(temp);
          }
        });

        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (_, i) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(list[i].main,style: Theme.of(context).textTheme.display1,),
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      ...list[i].sub.asMap().map((a, d) {
                        return MapEntry(
                            a,
                            ListTile(
                              title: Text(d),
                              subtitle: Text(
                                  "Reps : ${list[i].info[a].reps} Weight : ${list[i].info[a].weight} kg"),
                            ));
                      }).values
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
