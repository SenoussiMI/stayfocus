import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stayfocus/Models/exercise_model.dart';
import 'package:stayfocus/Models/program.model.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'stayfocus.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE exercises(
    id INTEGER PRIMARY KEY,
    name TEXT 
    )
    ''');

    await db.execute('''
    CREATE TABLE programs(
    id INTEGER PRIMARY KEY,
    name TEXT 
    )
    ''');

    /*
    await db.execute('''
    CREATE TABLE liaison(
    FOREIGN KEY (programsId) REFRENCES programs (id),
    FOREIGN KEY (exercicesId) REFRENCES exercices (id)
    )
    ''');
*/
  }



  Future<List<Exercise>> getexercises() async {
    Database db = await instance.database;
    var exercises = await db.query('exercises', orderBy: 'name');
    List<Exercise> exerciseList = exercises.isNotEmpty
        ? exercises.map((c) => Exercise.fromMap(c)).toList()
        : [];
    return exerciseList;
  }

  Future<int> addExercise(Exercise exercise) async {
    Database db = await instance.database;
    return await db.insert('exercises', exercise.toMap());
  }

  Future removeExercise(int id) async {
    Database db = await instance.database;
    return await db.delete('exercises', where: 'id =?', whereArgs: [id]);
  }

  Future<int> updateExercise(Exercise exercise) async {
    Database db = await instance.database;
    return await db.update('exercises',exercise.toMap(), where: 'id =?', whereArgs: [exercise.id]);
  }


  Future<List<Program>> getprograms() async {
    Database db = await instance.database;
    var programs = await db.query('programs', orderBy: 'name');
    List<Program> programsList = programs.isNotEmpty
        ? programs.map((c) => Program.fromMap(c)).toList()
        : [];
    return programsList;
  }

  Future<int> addProgram(Program program) async {
    Database db = await instance.database;
    return await db.insert('programs', program.toMap());
  }

  Future removeProgram(int id) async {
    Database db = await instance.database;
    return await db.delete('programs', where: 'id =?', whereArgs: [id]);
  }

  Future<int> updateProgram(Program program) async {
    Database db = await instance.database;
    return await db.update('programs',program.toMap(), where: 'id =?', whereArgs: [program.id]);
  }

}
