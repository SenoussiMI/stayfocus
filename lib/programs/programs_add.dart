import 'package:flutter/material.dart';
import 'package:stayfocus/Models/exercise_model.dart';
import 'package:stayfocus/Models/program.model.dart';
import 'package:stayfocus/db/DatabaseHelper.dart';
import 'package:stayfocus/home/home_page.dart';

class ProgramsAdd extends StatefulWidget {
  const ProgramsAdd({Key? key}) : super(key: key);

  @override
  State<ProgramsAdd> createState() => _ProgramsAddState();
}

class _ProgramsAddState extends State<ProgramsAdd> {
  int? selectedId;
  late List<int?> selectedGroup;
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: TextField(
              controller: textController,
            ),
          ),
          Center(
            child: FutureBuilder<List<Exercise>>(
                future: DatabaseHelper.instance.getexercises(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Exercise>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text('Chargement...'),
                    );
                  }
                  return snapshot.data!.isEmpty
                      ? Center(child: Text('Aucun exercise trouvé.'))
                      : Container(
                          child: ListView(
                            shrinkWrap: true,
                            children: snapshot.data!.map((Exercise) {
                              return Center(
                                child: Card(
                                  color: selectedId == Exercise.id
                                      ? Colors.black45
                                      : Colors.black12,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      child: Icon(
                                        Icons.sports_gymnastics,
                                      ),
                                    ),
                                    title: Text(Exercise.name),
                                    onTap: () {
                                      setState(() {
                                        if (selectedId == null) {
                                          textController.text = Exercise.name;
                                          selectedId = Exercise.id;
                                          //  selectedGroup.add(selectedId);
                                        } else {
                                          textController.text = '';
                                          selectedId = null;
                                        }
                                      });
                                    },
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () async {
          textController.text == ''
              ? Navigator.pop(context)
              : await DatabaseHelper.instance
                  .addProgram(Program(name: textController.text));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        },
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
