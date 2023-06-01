import 'package:sqflite/sqflite.dart';
import 'package:stayfocus/db/databaseCenter.dart';
import 'package:stayfocus/api/models/models.dart';

class ExercisesApi {
  Future<List<Exercise>> getexercises() async {
    Database db = await DatabaseHelper.instance.database;
    var exercises = await db.query('exercises', orderBy: 'name');
    List<Exercise> exerciseList = exercises.isNotEmpty
        ? exercises.map((c) => Exercise.fromMap(c)).toList()
        : [];
    return exerciseList;
  }

  Future<int> addExercise(Exercise exercise) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert('exercises', exercise.toMap());
  }

  Future removeExercise(int id) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.delete('exercises', where: 'id =?', whereArgs: [id]);
  }

  Future<int> updateExercise(Exercise exercise) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.update('exercises',exercise.toMap(), where: 'id =?', whereArgs: [exercise.id]);
  }
}