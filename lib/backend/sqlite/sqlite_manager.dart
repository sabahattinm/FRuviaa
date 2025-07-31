import 'package:flutter/foundation.dart';

import '/backend/sqlite/init.dart';
import 'queries/read.dart';
import 'queries/update.dart';

import 'package:sqflite/sqflite.dart';
export 'queries/read.dart';
export 'queries/update.dart';

class SQLiteManager {
  SQLiteManager._();

  static SQLiteManager? _instance;
  static SQLiteManager get instance => _instance ??= SQLiteManager._();

  static late Database _database;
  Database get database => _database;

  static Future initialize() async {
    if (kIsWeb) {
      return;
    }
    _database = await initializeDatabaseFromDbFile(
      'my_photo',
      'gorsel_html.db',
    );
  }

  /// START READ QUERY CALLS

  Future<List<ShowPhotoRow>> showPhoto({
    String? userId,
  }) =>
      performShowPhoto(
        _database,
        userId: userId,
      );

  /// END READ QUERY CALLS

  /// START UPDATE QUERY CALLS

  Future addPhoto({
    String? userId,
    String? filePath,
    String? description,
  }) =>
      performAddPhoto(
        _database,
        userId: userId,
        filePath: filePath,
        description: description,
      );

  /// END UPDATE QUERY CALLS
}
