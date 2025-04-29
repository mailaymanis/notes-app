// ignore_for_file: depend_on_referenced_packages
import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDatabase {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDatabase();
      return _db!;
    } else {
      return _db;
    }
  }

  initialDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes.db');
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return database;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE notes (id INTEGER PRIMARY KEY NOT NULL , title TEXT NOT NULL , content TEXT NOT NULL )",
    );
    log("onCreate Success==========");
  }

  //create database operations ==> (select / insert , update , delete)

  // 1) select/read
  readData(String sql) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }

  // 2) select/read
  insertData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  // 3) update
  updateData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }

  // 4) update
  deleteeData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }
}
