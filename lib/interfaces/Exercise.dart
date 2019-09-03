class ExerciseInfo {
  int reps;
  int weight;

  ExerciseInfo({this.reps, this.weight});
}

class Exercise {
  String main;
  List<String> sub;
  List<ExerciseInfo> info;

  Exercise(){
    sub = List<String>();
    info = List<ExerciseInfo>();
  }

  void setMain(String _main) {
    main = _main;
  }

  void addSub(String _sub) {
    sub.add(_sub);
  }

  void setInfo({int newReps, int newWeight}) {
    ExerciseInfo temp = ExerciseInfo(reps: newReps, weight: newWeight);
    info.add(temp);
  }
}
