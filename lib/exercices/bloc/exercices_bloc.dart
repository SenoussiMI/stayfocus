import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfocus/repository/repository.dart';
import 'package:stayfocus/api/models/models.dart';

part 'exercices_event.dart';
part 'exercices_state.dart';

class ExercicesBloc extends Bloc<ExercicesEvent, ExercicesState> {
  final Repository repository;

  ExercicesBloc({required this.repository}) : super(ExercicesInitial()) {
    on<LoadExercices>(_onLoadExercices);
    on<AddExercise>(_onAddExercise);
    on<RemoveExercise>(_onRemoveExercise);
  }

  void _onLoadExercices(LoadExercices event, Emitter<ExercicesState> emit) async {
    emit(ExercicesLoading());

    try {
      List<Exercise> exercices = await repository.getExercises() as List<Exercise>;

      emit(ExercicesLoaded(exercices: exercices));
    } catch (error) {
      emit(ExercicesError(error: error.toString()));
    }
  }

  void _onAddExercise(AddExercise event, Emitter<ExercicesState> emit) async {
    try {
      // Vérifier si l'exercice existe déjà
      final existingExercises = (state as ExercicesLoaded).exercices;
      if (existingExercises.any((exercise) => exercise.name == event.exerciseName)) {
        emit(ExercicesError(error: 'Exercise already exists.'));
      } else {
        // Ajouter l'exercice à la liste
        final newExercise = event.exercise;
        final updatedExercises = [...existingExercises, newExercise];
        emit(ExercicesLoaded(exercices: updatedExercises));

        // Ajouter l'exercice à la base de données en utilisant le repository
        await repository.addExercise(newExercise);
      }
    } catch (error) {
      emit(ExercicesError(error: error.toString()));
    }
  }

  void _onRemoveExercise(RemoveExercise event, Emitter<ExercicesState> emit) async {
    try {
      if (state is ExercicesLoaded) {
        // Supprimer l'exercice de la base de données en utilisant le repository
        if (event.exercise.id != null) {
          await repository.removeExercise(event.exercise.id!);
        } else {
          emit(ExercicesError(error: 'Exercise ID is null.'));
          return;
        }

        // Recharger la liste des exercices après la suppression
        List<Exercise> updatedExercises = List.from((state as ExercicesLoaded).exercices);
        updatedExercises.remove(event.exercise);
        emit(ExercicesLoaded(exercices: updatedExercises));
      } else {
        emit(ExercicesError(error: 'Invalid state: ${state.runtimeType}'));
      }
    } catch (error) {
      emit(ExercicesError(error: error.toString()));
    }
  }

}
