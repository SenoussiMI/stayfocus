import 'package:sqflite/sqflite.dart';
import 'package:stayfocus/db/databaseCenter.dart';
import 'package:stayfocus/api/models/models.dart';

class ProgramsApi {
  Future<List<Program>> getprograms() async {
    Database db = await DatabaseHelper.instance.database;
    var programs = await db.query('programs', orderBy: 'name');
    List<Program> programsList = programs.isNotEmpty
        ? programs.map((c) => Program.fromMap(c)).toList()
        : [];
    return programsList;
  }

  Future<int> addProgram(Program program) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert('programs', program.toMap());
  }

  Future removeProgram(int id) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.delete('programs', where: 'id =?', whereArgs: [id]);
  }

  Future<int> updateProgram(Program program) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.update('programs', program.toMap(), where: 'id =?', whereArgs: [program.id]);
  }
}
