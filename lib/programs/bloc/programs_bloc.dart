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
    on<AddProgram>(_onAddProgram);
  }

  void _onLoadPrograms(LoadPrograms event, Emitter<ProgramsState> emit) async {
    emit(ProgramsLoading());

    try {
      List<Program> programs = await repository.getPrograms() as List<Program>;

      emit(ProgramsLoaded(programs: programs));
    } catch (error) {
      emit(ProgramsError(error: error.toString()));
    }
  }

  void _onAddProgram(AddProgram event, Emitter<ProgramsState> emit) async {
    try {
      // Vérifier si le programme existe déjà
      final existingPrograms = (state as ProgramsLoaded).programs;
      if (existingPrograms.any((program) => program.name == event.programName)) {
        emit(ProgramsError(error: 'Program already exists.'));
      } else {
        // Ajouter le programme à la liste
        final newProgram = event.program;
        final updatedPrograms = [...existingPrograms, newProgram];
        emit(ProgramsLoaded(programs: updatedPrograms));

        // Ajouter le programme à la base de données en utilisant le repository
        await repository.addProgram(newProgram);
      }
    } catch (error) {
      emit(ProgramsError(error: error.toString()));
    }
  }
}
