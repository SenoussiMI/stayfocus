
class Repository {
  final dynamic exercisesApi;
  final dynamic programsApi;

  const Repository({
    required this.exercisesApi,
    required this.programsApi,
  });

  Future<List<dynamic>> getExercises() => exercisesApi.getexercises();

  Future<int> addExercise(dynamic exercise) => exercisesApi.addExercise(exercise);

  Future removeExercise(int id) => exercisesApi.removeExercise(id);

  Future<int> updateExercise(dynamic exercise) => exercisesApi.updateExercise(exercise);

  Future<List<dynamic>> getPrograms() => programsApi.getprograms();

  Future<int> addProgram(dynamic program) => programsApi.addProgram(program);

  Future removeProgram(int id) => programsApi.removeProgram(id);

  Future<int> updateProgram(dynamic program) => programsApi.updateProgram(program);

}
