part of 'programs_bloc.dart';

abstract class ProgramsState extends Equatable {
  const ProgramsState();
}

class ProgramsInitial extends ProgramsState {
  @override
  List<Object> get props => [];
}
