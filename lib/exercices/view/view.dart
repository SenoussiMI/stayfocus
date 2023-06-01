import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stayfocus/exercices/bloc/exercices_bloc.dart';
import 'package:stayfocus/repository/repository.dart';

import 'package:stayfocus/api/api.dart';

class ExercicesView extends StatelessWidget {
  ExercicesView({Key? key}) : super(key: key);
  final exercicesapi = ExercisesApi();
  final programsapi = ProgramsApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercises'),
      ),
      body: BlocProvider(
        create: (context) => ExercicesBloc(
            repository: Repository(
                exercisesApi: exercicesapi, programsApi: programsapi))..add(LoadExercices()),
        child: BlocBuilder<ExercicesBloc, ExercicesState>(
          builder: (context, state) {
            if (state is ExercicesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ExercicesLoaded) {
              final exercices = state.exercices;

              return ListView.builder(
                itemCount: exercices.length,
                itemBuilder: (context, index) {
                  final exercise = exercices[index];

                  return ListTile(
                    title: Text(exercise.name),
                    // Ajoutez d'autres widgets pour afficher les détails de l'exercice si nécessaire
                  );
                },
              );
            } else if (state is ExercicesError) {
              return Center(
                child: Text('An error occurred: ${state.error}'),
              );
            }

            // Par défaut, afficher un texte générique si l'état n'est pas géré
            return const Center(
              child: Text('Exercises Page'),
            );
          },
        ),
      ),
    );
  }
}
