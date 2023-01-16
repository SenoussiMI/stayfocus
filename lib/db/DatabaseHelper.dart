import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stayfocus/Models/exercise_model.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'exercises.db');
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
  }

  Future<List<Exercise>> getexercises() async {
    Database db = await instance.database;
    var exercises = await db.query('exercises', orderBy: 'name');
    List<Exercise> exerciseList = exercises.isNotEmpty
        ? exercises.map((c) => Exercise.fromMap(c)).toList()
        : [];
    return exerciseList;
  }

  Future<int> add(Exercise exercise) async {
    Database db = await instance.database;
    return await db.insert('exercises', exercise.toMap());
  }

  Future remove(int id) async {
    Database db = await instance.database;
    return await db.delete('exercises', where: 'id =?', whereArgs: [id]);
  }

  Future<int> update(Exercise exercise) async {
    Database db = await instance.database;
    return await db.update('exercises',exercise.toMap(), where: 'id =?', whereArgs: [exercise.id]);
  }

}
