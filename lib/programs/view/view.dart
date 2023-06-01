import 'package:flutter/material.dart';

class ProgramsView extends StatelessWidget {
  const ProgramsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Programs'),
      ),
      body: const Center(
        child: Text('Programs Page'),
      ),
    );
  }
}
