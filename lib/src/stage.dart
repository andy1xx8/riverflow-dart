import 'dart:convert';

import 'package:riverflow/src/dom_stage.dart';
import 'package:riverflow/src/domain/record.dart';

class StageTypes {
  StageTypes._();

  static const DOM = 'dom';
}

abstract class Stage {
  final String type;

  Stage(this.type);

  List<Record> process(Record inputRecord);

  factory Stage.fromJson(Map<String, dynamic> json) {
    final type = json['type'];
    if (type == null) {
      throw FormatException('This is not a valid json for this barrage: ${jsonEncode(json)}');
    }
    switch (type) {
      case StageTypes.DOM:
        return DomStage.fromJson(json);
      default:
        throw UnsupportedError('Unknown Barrage Type: $type');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
    };
  }
}
