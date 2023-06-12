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
    on<UpdateProgram>(_onUpdateProgram);
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
      
      final existingPrograms = (state as ProgramsLoaded).programs;
      if (existingPrograms.any((program) => program.name == event.programName)) {
        emit(ProgramsError(error: 'Program already exists.'));
      } else {
        
        final newProgram = event.program;
        final updatedPrograms = [...existingPrograms, newProgram];
        emit(ProgramsLoaded(programs: updatedPrograms));

        
        await repository.addProgram(newProgram);
      }
    } catch (error) {
      emit(ProgramsError(error: error.toString()));
    }
  }

  void _onUpdateProgram(UpdateProgram event, Emitter<ProgramsState> emit) async {
    try {
      final existingPrograms = (state as ProgramsLoaded).programs;
      final updatedPrograms = existingPrograms.map((program) {
        if (program.id == event.program.id) {
          return event.program;
        } else {
          return program;
        }
      }).toList();
      emit(ProgramsLoaded(programs: updatedPrograms));

      
      await repository.updateProgram(event.program);
    } catch (error) {
      emit(ProgramsError(error: error.toString()));
    }
  }

}
