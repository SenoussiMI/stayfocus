import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<ToggleDoNotDisturb>(_onToggleDoNotDisturb);
  }

  void _onToggleDoNotDisturb(ToggleDoNotDisturb event, Emitter<SettingsState> emit) {
    emit(DoNotDisturbState(event.isEnabled));
  }
}
