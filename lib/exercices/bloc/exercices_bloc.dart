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
      
      final existingExercises = (state as ExercicesLoaded).exercices;
      if (existingExercises.any((exercise) => exercise.name == event.exerciseName)) {
        emit(ExercicesError(error: 'Exercise already exists.'));
      } else {
        
        final newExercise = event.exercise;
        final updatedExercises = [...existingExercises, newExercise];
        emit(ExercicesLoaded(exercices: updatedExercises));

        
        await repository.addExercise(newExercise);
      }
    } catch (error) {
      emit(ExercicesError(error: error.toString()));
    }
  }

  void _onRemoveExercise(RemoveExercise event, Emitter<ExercicesState> emit) async {
    try {
      if (state is ExercicesLoaded) {
        
        if (event.exercise.id != null) {
          await repository.removeExercise(event.exercise.id!);
        } else {
          emit(ExercicesError(error: 'Exercise ID is null.'));
          return;
        }

        
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
