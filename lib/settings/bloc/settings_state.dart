part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
}

class SettingsInitial extends SettingsState {
  @override
  List<Object> get props => [];
}


class DoNotDisturbState extends SettingsState {
  final bool isEnabled;

  DoNotDisturbState(this.isEnabled);

  @override
  List<Object> get props => [isEnabled];
}


