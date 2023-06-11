part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class ToggleDoNotDisturb extends SettingsEvent {
  final bool isEnabled;

  ToggleDoNotDisturb(this.isEnabled);

  @override
  List<Object> get props => [isEnabled];
}

