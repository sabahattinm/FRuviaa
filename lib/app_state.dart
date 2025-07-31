import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import '/backend/api_requests/api_manager.dart';
import 'backend/supabase/supabase.dart';
import '/backend/sqlite/sqlite_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:synchronized/synchronized.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    secureStorage = FlutterSecureStorage();
    await _safeInitAsync(() async {
      _apiBaseUrl =
          await secureStorage.getString('ff_apiBaseUrl') ?? _apiBaseUrl;
    });
    await _safeInitAsync(() async {
      _kontrol = await secureStorage.getString('ff_kontrol') ?? _kontrol;
    });
    await _safeInitAsync(() async {
      _seenWalkthrough =
          await secureStorage.getBool('ff_seenWalkthrough') ?? _seenWalkthrough;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  String _nutritionInfo = '';
  String get nutritionInfo => _nutritionInfo;
  set nutritionInfo(String value) {
    _nutritionInfo = value;
  }

  String _analyzedImageBytes = '';
  String get analyzedImageBytes => _analyzedImageBytes;
  set analyzedImageBytes(String value) {
    _analyzedImageBytes = value;
  }

  bool _isAnalyzing = false;
  bool get isAnalyzing => _isAnalyzing;
  set isAnalyzing(bool value) {
    _isAnalyzing = value;
  }

  bool _analysisComplete = false;
  bool get analysisComplete => _analysisComplete;
  set analysisComplete(bool value) {
    _analysisComplete = value;
  }

  bool _hasError = false;
  bool get hasError => _hasError;
  set hasError(bool value) {
    _hasError = value;
  }

  String _lastError = '';
  String get lastError => _lastError;
  set lastError(String value) {
    _lastError = value;
  }

  String _apiBaseUrl = 'https://1fcbcd648440.ngrok-free.app';
  String get apiBaseUrl => _apiBaseUrl;
  set apiBaseUrl(String value) {
    _apiBaseUrl = value;
    secureStorage.setString('ff_apiBaseUrl', value);
  }

  void deleteApiBaseUrl() {
    secureStorage.delete(key: 'ff_apiBaseUrl');
  }

  String _currentImagePath = '';
  String get currentImagePath => _currentImagePath;
  set currentImagePath(String value) {
    _currentImagePath = value;
  }

  String _kontrol = '';
  String get kontrol => _kontrol;
  set kontrol(String value) {
    _kontrol = value;
    secureStorage.setString('ff_kontrol', value);
  }

  void deleteKontrol() {
    secureStorage.delete(key: 'ff_kontrol');
  }

  bool _seenWalkthrough = false;
  bool get seenWalkthrough => _seenWalkthrough;
  set seenWalkthrough(bool value) {
    _seenWalkthrough = value;
    secureStorage.setBool('ff_seenWalkthrough', value);
  }

  void deleteSeenWalkthrough() {
    secureStorage.delete(key: 'ff_seenWalkthrough');
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: ListToCsvConverter().convert([value]));
}
