import 'package:flutter/material.dart';
import 'home/home.dart';
import 'programs/programs.dart';
import 'exercices/exercices.dart';
import 'repository/repository.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> _pages = [
    HomeView(),
    ProgramsView(),
    ExercicesView(),
  ];




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: 'Programs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: 'Exercises',
            ),
          ],
        ),
      ),
    );
  }
}

