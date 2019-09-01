import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  @override
  ExerciseState get initialState => InitialExerciseState();

  @override
  Stream<ExerciseState> mapEventToState(
    ExerciseEvent event,
  ) async* {
    if (event is AppStarted) {
      print("Loading Data");
    }

    if (event is GoogleLogin) {
      print("Google Login");
    }
  }
}
