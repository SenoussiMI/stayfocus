part of 'exercices_bloc.dart';

abstract class ExercicesEvent extends Equatable {
  const ExercicesEvent();

  @override
  List<Object> get props => [];
}

class LoadExercices extends ExercicesEvent {}


class AddExercise extends ExercicesEvent {
  final Exercise exercise;

  AddExercise(this.exercise);

  String get exerciseName => exercise.name;

  @override
  List<Object> get props => [exercise];
}

class RemoveExercise extends ExercicesEvent {
  final Exercise exercise;

  RemoveExercise(this.exercise);

  @override
  List<Object> get props => [exercise];
}
