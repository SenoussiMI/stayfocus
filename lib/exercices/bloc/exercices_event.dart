part of 'exercices_bloc.dart';

abstract class ExercicesEvent extends Equatable {
  const ExercicesEvent();

  @override
  List<Object> get props => [];
}

class LoadExercices extends ExercicesEvent {}
// Ajoutez d'autres événements si nécessaire

class AddExercise extends ExercicesEvent {
  final Exercise exercise;

  AddExercise(this.exercise);

  String get exerciseName => exercise.name;

  @override
  List<Object> get props => [exercise];
}