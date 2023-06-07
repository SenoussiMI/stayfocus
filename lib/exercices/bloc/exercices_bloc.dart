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
  }

  void _onLoadExercices(LoadExercices event, Emitter<ExercicesState> emit) async {
    emit(ExercicesLoading());

    try {
      List<Exercise> exercices = await repository.getExercises();

      emit(ExercicesLoaded(exercices: exercices));
    } catch (error) {
      emit(ExercicesError(error: error.toString()));
    }
  }

}
