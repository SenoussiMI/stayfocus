import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stayfocus/Api/exercises_api.dart';
import 'package:stayfocus/Api/programs_api.dart';

class DatabaseHelper extends ProgramsApi with ExercisesApi {
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

    await db.rawInsert('''
    INSERT INTO exercises (name) VALUES ('Dead lift'), ('Pull up'), ('Squats'))
    ''');

    await db.rawInsert('''
    INSERT INTO programs (name) VALUES ('Jambes'), ('Pecs'), ('Dos'))
    ''');

    /*
    THIS TABLE IS NOT INCLUDED
    await db.execute('''
    CREATE TABLE liaison(
    FOREIGN KEY (programsId) REFRENCES programs (id),
    FOREIGN KEY (exercicesId) REFRENCES exercices (id)
    )
    ''');
*/
  }
}
