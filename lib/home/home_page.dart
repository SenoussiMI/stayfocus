import 'package:flutter/material.dart';
import 'package:stayfocus/exercises/exercises_list.dart';
import 'package:stayfocus/programs/programs_list.dart';
import 'package:stayfocus/settings/settings_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController _pageController;
  int _currentIndex = 1 ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(
        initialPage: _currentIndex,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
       controller: _pageController, 
        children: const <Widget>[
          Settings(),
          Programs(),
          Exercises(),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(_currentIndex);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Paramètres',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Sets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_gymnastics),
            label: 'Exercices',
          ),
        ],
      ),
    );
  }
}
