import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class DB_helper with ChangeNotifier {
  static const task_id = "id";
  static const task_text = "text";
  static const task_checking = "checking";
  static final DB_helper instnace = new DB_helper.internal();

  //factory DB_helper() => instnace;

  DB_helper.internal();

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await creat();
      return _db;
    }
  }

  void reset_db() {
    print("nomi");
  }

  creat() async {
    var direcroty = await getApplicationDocumentsDirectory();
    String path = join(direcroty.path, "sqqqqmqrpqps.db");
    return await openDatabase(path, version: 1, onCreate: oncreate);
  }

  oncreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE Tasks(
      $task_id INTEGER PRIMARY KEY,
      $task_checking INTEGER,
      $task_text TEXT
      )
      ''',
    );
  }

  Future<int> insertt(Map<String, dynamic> row) async {
    Database dbb = await DB_helper.instnace.db;

    return await dbb.insert("Tasks", row);
  }

  Future<List<Map<String, dynamic>>> Query_all() async {
    Database db = await DB_helper.instnace.db;
    return await db.query("Tasks");
  }

  Future<int> update({int id, int checked}) async {
    Database db = await DB_helper.instnace.db;
    db.rawUpdate('''
    UPDATE Tasks
    SET ${DB_helper.task_checking} = $checked
    WHERE id = $id;
    ''');
    /*await db.update("Tasks", row,
        where: "$task_id = ?", whereArgs: [row["$task_id"]]);*/
  }

  Future<int> delete(int i) async {
    Database db = await DB_helper.instnace.db;

    return await db.delete("Tasks", where: "$task_id = ?", whereArgs: [i]);
  }
}
