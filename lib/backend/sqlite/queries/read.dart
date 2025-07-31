import '/backend/sqlite/queries/sqlite_row.dart';
import 'package:sqflite/sqflite.dart';

Future<List<T>> _readQuery<T>(
  Database database,
  String query,
  T Function(Map<String, dynamic>) create,
) =>
    database.rawQuery(query).then((r) => r.map((e) => create(e)).toList());

/// BEGIN SHOWPHOTO
Future<List<ShowPhotoRow>> performShowPhoto(
  Database database, {
  String? userId,
}) {
  final query = '''
SELECT * FROM  Photos WHERE user_id = '${userId}'
''';
  return _readQuery(database, query, (d) => ShowPhotoRow(d));
}

class ShowPhotoRow extends SqliteRow {
  ShowPhotoRow(Map<String, dynamic> data) : super(data);

  String? get photoPath => data['photoPath'] as String?;
  String? get description => data['description'] as String?;
}

/// END SHOWPHOTO
