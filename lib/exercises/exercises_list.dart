import 'package:flutter/material.dart';
import 'package:stayfocus/Models/exercise_model.dart';
import 'package:stayfocus/db/DatabaseHelper.dart';

/*
const List<Map<String, dynamic>> listExercices = [
  {
    'name': 'Muscle up',
  },
  {
    'name': 'Pull up',
  },
];

 */

class Exercises extends StatefulWidget {
  const Exercises({Key? key}) : super(key: key);

  @override
  State<Exercises> createState() => _ExercisesState();
}

class _ExercisesState extends State<Exercises> {
  int? selectedId;
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes exercises'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: textController,
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
                                    title: Text(Exercise.name),
                                    onTap: () {
                                      setState(() {
                                        if (selectedId == null) {
                                          textController.text = Exercise.name;
                                          selectedId = Exercise.id;
                                        } else {
                                          textController.text = '';
                                          selectedId = null;
                                        }
                                      });
                                    },
                                    onLongPress: () {
                                      setState(() {
                                        DatabaseHelper.instance
                                            .remove(Exercise.id!);
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
        child: Icon(Icons.add),
        onPressed: () async {
          selectedId != null
              ? await DatabaseHelper.instance.update(
                  Exercise(id: selectedId, name: textController.text),
                )
              : await DatabaseHelper.instance
                  .add(Exercise(name: textController.text));
          setState(() {
            textController.clear();
          });
        },
      ),
    );
  }
}
