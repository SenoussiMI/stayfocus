import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool darkmode = false;
  dynamic savedThemeMode;
  late String iconAdress;

  void initState() {
    super.initState();
    getCurrentTheme();
  }

  Future getCurrentTheme() async {
    savedThemeMode = await AdaptiveTheme.getThemeMode();
    if(savedThemeMode.toString() == 'AdaptiveTheme.dark'){
      print('thème sombre');

      setState(() {
        darkmode = true;
        iconAdress = 'assets/icon/sombre.png';
      });
    } else {
      print('thème clair');
      setState(() {
        darkmode = false;
        iconAdress = 'assets/icon/clair.png';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body : Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Container(
               height: 150,
                 child: iconAdress!= null ? Image.asset(iconAdress) : Container(),
             ),
             SizedBox(height: 70),
             Text(
               'Changez de théme',
               style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),

             ),
             SizedBox(height: 20),
             Container(
               width: 250,
               child: Text(
                 "Vous pouvez changer le thème de l'interface de votre application.",
                 textAlign: TextAlign.center,
               ),
             ),

             SizedBox(height: 20),
            SwitchListTile(
              title: Text('Mode sombre'),
              activeColor: Colors.orange,
              value: darkmode,
                onChanged: (bool value) {
                if (value == true) {
                  AdaptiveTheme.of(context).setDark();
                  iconAdress = 'assets/icon/sombre.png';
                } else {
                  AdaptiveTheme.of(context).setLight();
                  iconAdress = 'assets/icon/clair.png';
                }
                setState(() {
                  darkmode = value;
                });
                },
            ),
           ],
         )
        ),
    );
  }
}
