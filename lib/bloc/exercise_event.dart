import 'package:gymtrackerandroid/bloc/exercise_bloc.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ExerciseEvent {}

class AppStarted extends ExerciseEvent{
  @override
  String toString(){
    return "App Started";
  }
}
 
class GoogleLogin extends ExerciseEvent{
  @override
  String toString() {
    return "Login With Google";
  }
}