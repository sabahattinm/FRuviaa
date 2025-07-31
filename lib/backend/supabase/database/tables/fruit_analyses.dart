import '../database.dart';

class FruitAnalysesTable extends SupabaseTable<FruitAnalysesRow> {
  @override
  String get tableName => 'fruit_analyses';

  @override
  FruitAnalysesRow createRow(Map<String, dynamic> data) =>
      FruitAnalysesRow(data);
}

class FruitAnalysesRow extends SupabaseDataRow {
  FruitAnalysesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => FruitAnalysesTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String get originalImageUrl => getField<String>('original_image_url')!;
  set originalImageUrl(String value) =>
      setField<String>('original_image_url', value);

  String? get processedImageUrl => getField<String>('processed_image_url');
  set processedImageUrl(String? value) =>
      setField<String>('processed_image_url', value);

  String? get nutritionInfo => getField<String>('nutrition_info');
  set nutritionInfo(String? value) => setField<String>('nutrition_info', value);

  dynamic? get apiResponse => getField<dynamic>('api_response');
  set apiResponse(dynamic? value) => setField<dynamic>('api_response', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  DateTime? get updatedAt => getField<DateTime>('updated_at');
  set updatedAt(DateTime? value) => setField<DateTime>('updated_at', value);
}
