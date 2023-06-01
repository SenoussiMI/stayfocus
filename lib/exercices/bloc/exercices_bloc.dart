import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'exercices_event.dart';
part 'exercices_state.dart';

class ExercicesBloc extends Bloc<ExercicesEvent, ExercicesState> {
  ExercicesBloc() : super(ExercicesInitial()) {
    on<ExercicesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
