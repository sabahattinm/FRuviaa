// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DenemeStruct extends BaseStruct {
  DenemeStruct({
    String? mesaj,
    String? durum,
  })  : _mesaj = mesaj,
        _durum = durum;

  // "mesaj" field.
  String? _mesaj;
  String get mesaj => _mesaj ?? '';
  set mesaj(String? val) => _mesaj = val;

  bool hasMesaj() => _mesaj != null;

  // "durum" field.
  String? _durum;
  String get durum => _durum ?? '';
  set durum(String? val) => _durum = val;

  bool hasDurum() => _durum != null;

  static DenemeStruct fromMap(Map<String, dynamic> data) => DenemeStruct(
        mesaj: data['mesaj'] as String?,
        durum: data['durum'] as String?,
      );

  static DenemeStruct? maybeFromMap(dynamic data) =>
      data is Map ? DenemeStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'mesaj': _mesaj,
        'durum': _durum,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'mesaj': serializeParam(
          _mesaj,
          ParamType.String,
        ),
        'durum': serializeParam(
          _durum,
          ParamType.String,
        ),
      }.withoutNulls;

  static DenemeStruct fromSerializableMap(Map<String, dynamic> data) =>
      DenemeStruct(
        mesaj: deserializeParam(
          data['mesaj'],
          ParamType.String,
          false,
        ),
        durum: deserializeParam(
          data['durum'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DenemeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DenemeStruct &&
        mesaj == other.mesaj &&
        durum == other.durum;
  }

  @override
  int get hashCode => const ListEquality().hash([mesaj, durum]);
}

DenemeStruct createDenemeStruct({
  String? mesaj,
  String? durum,
}) =>
    DenemeStruct(
      mesaj: mesaj,
      durum: durum,
    );
