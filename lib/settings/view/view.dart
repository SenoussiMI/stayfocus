import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stayfocus/settings/bloc/settings_bloc.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (context) => SettingsBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            final settingsBloc = BlocProvider.of<SettingsBloc>(context);

            if (state is DoNotDisturbState) {
              return SwitchListTile(
                title: const Text('Do Not Disturb'),
                value: state.isEnabled,
                onChanged: (value) {
                  settingsBloc.add(ToggleDoNotDisturb(value));
                },
              );
            }

            return const Center(
              child: Text('Settings Page'),
            );
          },
        ),
      ),
    );
  }
}
