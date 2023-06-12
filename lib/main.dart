import 'package:flutter/material.dart';
import 'settings/settings.dart';
import 'programs/programs.dart';
import 'exercices/exercices.dart';
import 'repository/repository.dart';
import 'package:stayfocus/api/api.dart';

void main() {
  final exercicesApi = ExercisesApi();
  final programsApi = ProgramsApi();
  final languesApi = LanguesApi();
  final repository = Repository(
    exercisesApi: exercicesApi,
    programsApi: programsApi,
    languesApi: languesApi
  );

  runApp(MyApp(repository: repository));
}

class MyApp extends StatefulWidget {
  final Repository repository;

  MyApp({required this.repository});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final repository = widget.repository;

    final List<Widget> _pages = [
      ExercicesView(repository: repository),
      ProgramsView(repository: repository),
      SettingsView(repository: repository),
    ];

    return MaterialApp(
      title: 'StayFocus',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center),
              label: 'Exercises',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Programs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
