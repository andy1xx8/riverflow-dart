import 'package:html/dom.dart';

abstract class Field {}

/// This should support nested fields.
/// But at the moment, we don't support it.
class Record extends Field {
  final Map<String, dynamic> _fields = {};

  Record();

  Record.from(String k, dynamic v) {
    _fields[k] = v;
  }

  Record.fromMap(Map<String, dynamic> data) {
    data.forEach((key, value) {
      _fields[key] = value;
    });
  }

  bool contains(String field) => _fields.containsKey(field);

  dynamic path(String path) {
    final f = path.toFieldName();
    return f != null ? getField(f) : null;
  }

  dynamic get(String field) {
    return _fields[field];
  }

  dynamic getField(String fieldName) => _fields[fieldName];

  dynamic getFieldWithDefault(String fieldName, {dynamic defaultValue}) {
    return _fields[fieldName] ?? defaultValue;
  }

  List<String> getFieldNames() {
    return _fields.keys.toList();
  }

  bool? getBool(String field, {bool? defaultValue}) {
    return get(field) ?? defaultValue;
  }

  int? getInt(String field, {int? defaultValue}) {
    return get(field) ?? defaultValue;
  }

  double? getDouble(String field, {double? defaultValue}) {
    return get(field) ?? defaultValue;
  }

  String? getString(String field, {String? defaultValue}) {
    return get(field) ?? defaultValue;
  }

  Element? getElement(String field) {
    return get(field) as Element;
  }

  List? getList(String field) {
    return (getField(field) as List);
  }

  List<String>? getListString(String field, {List<String>? defaultValue}) {
    final rawList = getList(field);

    return (rawList != null)
        ? rawList.map<String>((e) => e as String).toList()
        : defaultValue;
  }

  List<Element>? getElements(String field, {List<Element>? defaultValue}) {
    final rawList = getList(field);

    return (rawList != null)
        ? rawList.map<Element>((e) => e as Element).toList()
        : defaultValue;
  }

  Record addField(String fieldName, dynamic fieldValue) {
    _fields[fieldName] = fieldValue;
    return this;
  }

  Record removeFields(List<String> excludeFields) {
    excludeFields.forEach((fieldName) {
      _fields.remove(fieldName);
    });
    return this;
  }

  Record removeField(String fieldName) {
    _fields.remove(fieldName);
    return this;
  }

  Map<String, dynamic> toJson() {
    dynamic toValue(dynamic value) {
      if (value is List) {
        return value.map((e) => toValue(e)).toList();
      } else if (value is Document) {
        return value.outerHtml;
      } else if (value is Element) {
        return value.outerHtml;
      } else if (value is DateTime) {
        return value.toString();
      } else {
        return value;
      }
    }

    return _fields.map((key, value) => MapEntry(key, toValue(value)));
  }

  /// Merge <@code otherRecord> to this record
  /// And return the result as a new record.
  Record mergeWith(Record otherRecord) {
    final newRecord = Record();
    _fields.forEach((key, value) {
      newRecord.addField(key, value);
    });

    otherRecord.getFieldNames().forEach((fieldName) {
      newRecord.addField(fieldName, otherRecord.getField(fieldName));
    });
    return newRecord;
  }
}

extension PathToField on String {
  String? toFieldName() {
    var regExp = RegExp('/(?<field_name>.+)');
    return regExp
        .allMatches(this)
        .map((element) => element.namedGroup('field_name'))
        .firstWhere((element) => true, orElse: () => null);
  }
}
