import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfocus/repository/repository.dart';
import 'package:stayfocus/api/models/models.dart';

part 'programs_event.dart';
part 'programs_state.dart';

class ProgramsBloc extends Bloc<ProgramsEvent, ProgramsState> {
  final Repository repository;

  ProgramsBloc({required this.repository}) : super(ProgramsInitial()) {
    on<LoadPrograms>(_onLoadPrograms);
  }

  void _onLoadPrograms(LoadPrograms event, Emitter<ProgramsState> emit) async {
    emit(ProgramsLoading());

    try {
      List<Program> programs = await repository.getPrograms();

      emit(ProgramsLoaded(programs: programs));
    } catch (error) {
      emit(ProgramsError(error: error.toString()));
    }
  }

// Ajoutez d'autres gestionnaires d'événements si nécessaire
}
