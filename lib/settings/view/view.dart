import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stayfocus/settings/bloc/settings_bloc.dart';
import 'package:stayfocus/repository/repository.dart';

class SettingsView extends StatelessWidget {
  final Repository repository;

  SettingsView({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: BlocProvider<SettingsBloc>(
        create: (context) => SettingsBloc(repository: repository)..add(LoadSupportedLanguages()),
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            if (state.supportedLanguages.isEmpty) {
              return Center(
                child: Text('No languages available.'),
              );
            } else {
              return Center(
                child: DropdownButton<String>(
                  value: state.currentLanguage,
                  onChanged: (newValue) {
                    context.read<SettingsBloc>().add(ChangeLanguage(newValue!));
                  },
                  items: state.supportedLanguages.map((lang) {
                    return DropdownMenuItem(
                      value: lang,
                      child: Text(lang),
                    );
                  }).toList(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
