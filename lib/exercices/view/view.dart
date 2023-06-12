import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stayfocus/exercices/bloc/exercices_bloc.dart';
import 'package:stayfocus/repository/repository.dart';
import 'package:stayfocus/api/models/models.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ExercicesView extends StatelessWidget {
  final Repository repository;
  final TextEditingController exerciseController = TextEditingController();

  ExercicesView({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Exercises',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: BlocProvider(
        create: (context) => ExercicesBloc(repository: repository)..add(LoadExercices()),
        child: BlocBuilder<ExercicesBloc, ExercicesState>(
          builder: (context, state) {
            if (state is ExercicesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ExercicesLoaded) {
              final exercices = state.exercices;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: exerciseController,
                            decoration: InputDecoration(
                              labelText: 'Exercise Name',
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            final newExercise = Exercise(name: exerciseController.text);
                            BlocProvider.of<ExercicesBloc>(context).add(AddExercise(newExercise));
                            exerciseController.clear();
                          },
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: exercices.length,
                      itemBuilder: (context, index) {
                        final exercise = exercices[index];

                        return GestureDetector(
                          onLongPress: () {
                            BlocProvider.of<ExercicesBloc>(context).add(RemoveExercise(exercise));
                            Fluttertoast.showToast(
                              msg: 'Exercice ${exercise.name} (ID: ${exercise.id}) successfully deleted',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.grey[800],
                              textColor: Colors.white,
                            );
                          },
                          child: ListTile(
                            title: Text(exercise.name),
                            // Ajoutez d'autres widgets pour afficher les détails de l'exercice si nécessaire
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is ExercicesError) {
              return Center(
                child: Text('An error occurred: ${state.error}'),
              );
            } else if (state is ExercicesRemoved) {
              final removedExercise = state.exercise;
              final exerciseName = removedExercise.name;
              final exerciseId = removedExercise.id;

              // Afficher une notification avec l'ID ou le nom de l'exercice supprimé
              Fluttertoast.showToast(
                msg: 'Exercice $exerciseName (ID: $exerciseId) successfully deleted',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.grey[800],
                textColor: Colors.white,
              );

              return Container(); // Ajout de ce widget Container vide pour retourner quelque chose
            }

            return const Center(
              child: Text('Exercises Page'),
            );
          },
        ),
      ),
    );
  }
}
