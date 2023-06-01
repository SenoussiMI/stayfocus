import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfocus/repository/repository.dart'; // Importez le repository

import 'package:stayfocus/api/models/models.dart';

part 'programs_event.dart';
part 'programs_state.dart';

class ProgramsBloc extends Bloc<ProgramsEvent, ProgramsState> {
  final Repository repository; // Ajoutez le repository comme dépendance

  ProgramsBloc({required this.repository}) : super(ProgramsInitial());

  @override
  Stream<ProgramsState> mapEventToState(ProgramsEvent event) async* {
    if (event is LoadPrograms) {
      yield* _mapLoadProgramsToState();
    }
    // Ajoutez d'autres conditions pour d'autres événements si nécessaire
  }

  Stream<ProgramsState> _mapLoadProgramsToState() async* {
    try {
      yield ProgramsLoading(); // Émettez un état de chargement

      List<Program> programs = await repository.getPrograms(); // Utilisez le repository pour obtenir la liste des programmes

      yield ProgramsLoaded(programs: programs); // Émettez un état avec les programmes chargés
    } catch (error) {
      yield ProgramsError(error: error.toString()); // Émettez un état d'erreur en cas d'échec
    }
  }
}


