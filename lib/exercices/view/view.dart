import 'package:flutter/material.dart';

class ExercicesView extends StatelessWidget {
  const ExercicesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercises'),
      ),
      body: const Center(
        child: Text('Exercises Page'),
      ),
    );
  }
}
