part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final String currentLanguage;
  final List<String> supportedLanguages;

  const SettingsState({
    required this.currentLanguage,
    required this.supportedLanguages,
  });

  @override
  List<Object> get props => [currentLanguage, supportedLanguages];

  SettingsState copyWith({
    String? currentLanguage,
    List<String>? supportedLanguages,
  }) {
    return SettingsState(
      currentLanguage: currentLanguage ?? this.currentLanguage,
      supportedLanguages: supportedLanguages ?? this.supportedLanguages,
    );
  }
}

class SettingsInitial extends SettingsState {
  const SettingsInitial({
    String currentLanguage = 'English',
    List<String> supportedLanguages = const [],
  }) : super(currentLanguage: currentLanguage, supportedLanguages: supportedLanguages);
}
