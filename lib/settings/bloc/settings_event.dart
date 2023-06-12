part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class ChangeLanguage extends SettingsEvent {
  final String language;

  ChangeLanguage(this.language);

  @override
  List<Object?> get props => [language];
}


class LoadSupportedLanguages extends SettingsEvent {
  @override
  List<Object> get props => [];
}
