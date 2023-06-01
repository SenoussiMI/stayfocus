part of 'programs_bloc.dart';

abstract class ProgramsState extends Equatable {
  const ProgramsState();

  @override
  List<Object> get props => [];
}

class ProgramsInitial extends ProgramsState {}

class ProgramsLoading extends ProgramsState {}

class ProgramsLoaded extends ProgramsState {
  final List<Program> programs;

  const ProgramsLoaded({required this.programs});

  @override
  List<Object> get props => [programs];
}

class ProgramsError extends ProgramsState {
  final String error;

  const ProgramsError({required this.error});

  @override
  List<Object> get props => [error];
}
