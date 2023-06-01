import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfocus/repository/repository.dart'; // Importez le repository
import 'package:stayfocus/api/models/models.dart';

part 'exercices_event.dart';
part 'exercices_state.dart';

class ExercicesBloc extends Bloc<ExercicesEvent, ExercicesState> {
  final Repository repository; // Ajoutez le repository comme dépendance

  ExercicesBloc({required this.repository}) : super(ExercicesInitial());

  @override
  Stream<ExercicesState> mapEventToState(ExercicesEvent event) async* {
    if (event is LoadExercices) {
      yield* _mapLoadExercicesToState();
    }
    // Ajoutez d'autres conditions pour d'autres événements si nécessaire
  }

    //avoir un onevent puis afficher event


  Stream<ExercicesState> _mapLoadExercicesToState() async* {
    try {
      yield ExercicesLoading(); // Émettez un état de chargement

      List<Exercise> exercices = await repository.getExercises(); // Utilisez le repository pour obtenir la liste des exercices

      yield ExercicesLoaded(exercices: exercices); // Émettez un état avec les exercices chargés
    } catch (error) {
      yield ExercicesError(error: error.toString()); // Émettez un état d'erreur en cas d'échec
    }
  }
}
