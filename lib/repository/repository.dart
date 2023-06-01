import 'package:stayfocus/api/api.dart';
import 'package:stayfocus/api/models/models.dart';

class Repository {
  final ExercisesApi exercisesApi;
  final ProgramsApi programsApi;

  const Repository({
    required this.exercisesApi,
    required this.programsApi,
  });

  Future<List<Exercise>> getExercises() => exercisesApi.getexercises();

  Future<int> addExercise(Exercise exercise) =>
      exercisesApi.addExercise(exercise);

  Future removeExercise(int id) => exercisesApi.removeExercise(id);

  Future<int> updateExercise(Exercise exercise) =>
      exercisesApi.updateExercise(exercise);

  Future<List<Program>> getPrograms() => programsApi.getprograms();

  Future<int> addProgram(Program program) => programsApi.addProgram(program);

  Future removeProgram(int id) => programsApi.removeProgram(id);

  Future<int> updateProgram(Program program) =>
      programsApi.updateProgram(program);
}
