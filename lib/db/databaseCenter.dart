import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'stayfocus.db');

    // Supprimer la base de données existante
    await deleteDatabase(path);

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
    INSERT INTO exercises (name) VALUES ('Dead lift'), ('Pull up'), ('Squats'), ('Burpees'), ('Bench press'), ('Handstand'), ('Push up'), ('Dips')
    ''');

    await db.rawInsert('''
    INSERT INTO programs (name) VALUES ('Pecs'), ('Dos'), ('Epaules'), ('Biceps'), ('Legs')
    ''');

    await db.execute('''
    CREATE TABLE liaison(
    programsId INTEGER,
    exercicesId INTEGER,
    FOREIGN KEY (programsId) REFERENCES programs (id),
    FOREIGN KEY (exercicesId) REFERENCES exercises (id)
    )
    ''');
  }
}
