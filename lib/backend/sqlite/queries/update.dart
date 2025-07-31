import 'package:sqflite/sqflite.dart';

/// BEGIN ADDPHOTO
Future performAddPhoto(
  Database database, {
  String? userId,
  String? filePath,
  String? description,
}) {
  final query = '''
INSERT INTO Photos (user_id, file_path, description) VALUES ('${userId}','${filePath}','${description}')
''';
  return database.rawQuery(query);
}

/// END ADDPHOTO
