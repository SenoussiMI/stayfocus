part of 'programs_bloc.dart';

abstract class ProgramsEvent extends Equatable {
  const ProgramsEvent();

  @override
  List<Object> get props => [];
}

class LoadPrograms extends ProgramsEvent {}
// Ajoutez d'autres événements si nécessaire
