part of 'exercices_bloc.dart';

abstract class ExercicesState extends Equatable {
  const ExercicesState();

  @override
  List<Object> get props => [];
}

class ExercicesInitial extends ExercicesState {}

class ExercicesLoading extends ExercicesState {}

class ExercicesLoaded extends ExercicesState {
  final List<Exercise> exercices;

  const ExercicesLoaded({required this.exercices});

  @override
  List<Object> get props => [exercices];
}

class ExercicesError extends ExercicesState {
  final String error;

  const ExercicesError({required this.error});

  @override
  List<Object> get props => [error];
}
