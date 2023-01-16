import 'package:flutter/material.dart';

class Programs extends StatelessWidget {
  const Programs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes programmes'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text("programmes"),
      ),
    );
  }
}
