import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LibraryDbService {
  static String _dbName = "library.db";
  static String _bookTable = "books";
  static String _authorTable = "author";
  static late Database _database;

  Future<void> createDatabase() async {
    final Directory dir =
        await getApplicationDocumentsDirectory();
    final String path = "${dir.path}/$_dbName";
    _database = await openDatabase(path);
    print(_database);
    await _createAuthorTable();
  }

  static Future<void> _createAuthorTable() async {
    return _database.execute(
      "create table if not exists $_authorTable(id integer primary key autoincrement, name text,description text,photo blob,fav integer)",
    );
  }

  Future<int> insertAuthor({
    required String name,
    required String description,
    Uint8List? photo,
  }) async {
    return _database.rawInsert(
      'insert into author (name,description,photo,fav) values(?,?,?,?)',
      [name, description, photo, null],
    );
  }

  Future<List<Map<String, dynamic>>>
  getAllAuthor() async {
    final authors = _database.rawQuery(
      "select * from $_authorTable ",
    );
    return authors;
  }
}
