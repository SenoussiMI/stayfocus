class Repository {
  final dynamic exercisesApi;
  final dynamic programsApi;
  final dynamic languesApi;

  const Repository({
    required this.exercisesApi,
    required this.programsApi,
    required this.languesApi,
  });

  Future<List<dynamic>> getExercises() => exercisesApi.getExercises();

  Future<int> addExercise(dynamic exercise) => exercisesApi.addExercise(exercise);

  Future removeExercise(int id) => exercisesApi.removeExercise(id);

  Future<int> updateExercise(dynamic exercise) => exercisesApi.updateExercise(exercise);

  Future<List<dynamic>> getPrograms() => programsApi.getPrograms();

  Future<int> addProgram(dynamic program) => programsApi.addProgram(program);

  Future removeProgram(int id) => programsApi.removeProgram(id);

  Future<int> updateProgram(dynamic program) => programsApi.updateProgram(program);

  Future<List<dynamic>> getLangues() => languesApi.getLangues();

  Future<int> addLangue(dynamic langue) => languesApi.addLangue(langue);

  Future removeLangue(int id) => languesApi.removeLangue(id);

  Future<int> updateLangue(dynamic langue) => languesApi.updateLangue(langue);
}
