part of 'programs_bloc.dart';

abstract class ProgramsEvent extends Equatable {
  const ProgramsEvent();

  @override
  List<Object> get props => [];
}

class LoadPrograms extends ProgramsEvent {}

class AddProgram extends ProgramsEvent {
  final Program program;

  AddProgram(this.program);

  String get programName => program.name;

  @override
  List<Object> get props => [program];
}

class UpdateProgram extends ProgramsEvent {
  final Program program;

  UpdateProgram(this.program);

  @override
  List<Object> get props => [program];
}

