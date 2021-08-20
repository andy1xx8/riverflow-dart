import 'package:riverflow/src/domain/record.dart';
import 'package:riverflow/src/extractors/filter.dart';
import 'package:riverflow/src/selector/field_selector.dart';
import 'package:riverflow/src/stage.dart';

class DomStage extends Stage {
  final Map<String, String> inputMapping;
  final Map<String, Selector> outputFields;
  final Set<String> excludeMapping;
  final Filter filter;

  DomStage({
    this.inputMapping,
    this.outputFields,
    this.excludeMapping,
    this.filter,
  }) : super(StageTypes.DOM);

  @override
  List<Record> process(Record inputRecord) {
    final inputMapping = _prepareInputs(inputRecord);
    final parseResult = _parseOutput(inputMapping);

    final record = Record().mergeWith(inputRecord).mergeWith(parseResult);
    final flattenFields = _getFlattenFields();
    return _buildOutputRecords(record, flattenFields);
  }

  Map<String, dynamic> _prepareInputs(Record inputRecord) {
    return inputMapping.map((fieldName, path) {
      return MapEntry(fieldName, inputRecord.path(path));
    });
  }

  Set<String> _getFlattenFields() {
    return outputFields.entries.where((e) => e.value.isFlatten ?? false).map((e) => e.key).toSet();
  }

  Record _parseOutput(Map<String, dynamic> inputMapping) {
    final outputMap = outputFields.map((fieldName, selector) {
      return MapEntry(fieldName, selector.select(inputMapping[fieldName]));
    });

    return Record.fromMap(outputMap);
  }

  List<Record> _buildOutputRecords(
    Record outputRecord,
    Set<String> flattenFields,
  ) {
    final records = _expandRecords(outputRecord, flattenFields);
    return _excludeFields(records);
  }

  List<Record> _expandRecords(Record record, Set<String> flattenFields) {
    final fieldName = flattenFields.firstWhere((fieldName) => true, orElse: () => null);
    if (fieldName == null) {
      return [record];
    } else {
      final flattenValues = record.getField(fieldName);
      if (flattenValues is List && fieldName.isNotEmpty) {
        return flattenValues.map((e) => record.mergeWith(Record.from(fieldName, e))).toList();
      } else {
        return [record];
      }
    }
  }

  List<Record> _excludeFields(List<Record> records) {
    if (excludeMapping == null || excludeMapping.isEmpty) {
      return records;
    } else {
      final excludeFields =
          excludeMapping.map((path) => path.toFieldName()).where((element) => element != null).toList();
      return records.map((record) => record.removeFields(excludeFields)).toList();
    }
  }

  factory DomStage.fromJson(Map<String, dynamic> json) {
    return DomStage(
      inputMapping: (json['input_mapping'] as Map).map((key, value) => MapEntry(key, value)),
      outputFields: (json['output_fields'] as Map).map((key, value) => MapEntry(key, Selector.fromJson(value))),
      excludeMapping: json['exclude_mapping'] != null
          ? json['exclude_mapping'].map<String>((e) => e.toString()).toSet()
          : <String>{},
      filter: json['filter'] != null ? Filter.fromJson(json['filter']) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'input_mapping': inputMapping,
      'output_fields': outputFields.map((key, value) => MapEntry(key, value.toJson())),
      'exclude_mapping': excludeMapping?.toList(),
      'filter': filter?.toJson(),
    };
  }
}
