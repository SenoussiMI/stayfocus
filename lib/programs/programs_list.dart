import 'package:flutter/material.dart';
import 'package:stayfocus/Models/program.model.dart';
import 'package:stayfocus/programs/programs_add.dart';
import 'package:stayfocus/db/DatabaseHelper.dart';

class Programs extends StatefulWidget {
  const Programs({Key? key}) : super(key: key);

  @override
  State<Programs> createState() => _ProgramsState();
}

class _ProgramsState extends State<Programs> {
  int? selectedId;
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes programmes'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: textController,
          ),
          Center(
            child: FutureBuilder<List<Program>>(
                future: DatabaseHelper.instance.getprograms(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Program>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text('Chargement...'),
                    );
                  }
                  return snapshot.data!.isEmpty
                      ? Center(child: Text('Aucun program trouvé.'))
                      : Container(
                          child: ListView(
                            shrinkWrap: true,
                            children: snapshot.data!.map((Program) {
                              return Center(
                                child: Card(
                                  color: selectedId == Program.id
                                      ? Colors.black45
                                      : Colors.black12,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      child: Icon(
                                        Icons.sports_gymnastics,
                                      ),
                                    ),
                                    title: Text(Program.name),
                                    onTap: () {
                                      setState(() {
                                        if (selectedId == null) {
                                          textController.text = Program.name;
                                          selectedId = Program.id;
                                        } else {
                                          textController.text = '';
                                          selectedId = null;
                                        }
                                      });
                                    },
                                    onLongPress: () {
                                      setState(() {
                                        DatabaseHelper.instance
                                            .removeProgram(Program.id!);
                                      });
                                      final snackBar = SnackBar(
                                        content:
                                            Text('Programme a été supprimé'),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProgramsAdd()),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
