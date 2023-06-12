import 'package:sqflite/sqflite.dart';
import 'package:stayfocus/db/databaseCenter.dart';
import 'package:stayfocus/api/models/models.dart';

class LanguesApi {
  Future<List<Langue>> getLangues() async {
    Database db = await DatabaseHelper.instance.database;
    var langues = await db.query('langues');
    List<Langue> langueList = langues.isNotEmpty
        ? langues.map((c) => Langue.fromMap(c)).toList()
        : [];
    return langueList;
  }

  Future<int> addLangue(Langue langue) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert('langues', langue.toMap());
  }

  Future removeLangue(int id) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.delete('langues', where: 'id =?', whereArgs: [id]);
  }

  Future<int> updateLangue(Langue langue) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.update('langues', langue.toMap(), where: 'id =?', whereArgs: [langue.id]);
  }
}
