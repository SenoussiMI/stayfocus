import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white), // Couleur du texte en blanc
        ),
        centerTitle: true, // Centrer le titre de l'AppBar
        backgroundColor: Colors.blue, // Couleur de fond bleue
      ),
      body: const Center(
        child: Text('Settings Page'),
      ),
    );
  }
}
