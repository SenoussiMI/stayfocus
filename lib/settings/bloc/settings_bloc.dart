import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfocus/repository/repository.dart';
import 'package:stayfocus/api/models/models.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final Repository repository;

  SettingsBloc({required this.repository}) : super(const SettingsInitial()) {
    on<LoadSupportedLanguages>(_onLoadSupportedLanguages);
    on<ChangeLanguage>(_onChangeLanguage);
  }

  void _onChangeLanguage(ChangeLanguage event, Emitter<SettingsState> emit) {
    final newState = state.copyWith(currentLanguage: event.language);
    emit(newState);
  }

  void _onLoadSupportedLanguages(LoadSupportedLanguages event, Emitter<SettingsState> emit) async {
    final supportedLanguages = await repository.getLangues();
    final supportedLanguagesStrings = supportedLanguages.map((lang) => lang.lang as String).toList();
    final newState = state.copyWith(supportedLanguages: supportedLanguagesStrings);
    emit(newState);
  }


}
