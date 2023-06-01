part of 'exercices_bloc.dart';

abstract class ExercicesEvent extends Equatable {
  const ExercicesEvent();

  @override
  List<Object> get props => [];
}

class LoadExercices extends ExercicesEvent {}
// Ajoutez d'autres événements si nécessaire
