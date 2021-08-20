import 'dart:convert';

import 'package:riverflow/riverflow.dart';
import 'package:riverflow/src/stage.dart';

class Template {
  final List<Stage> stages;

  Template(this.stages);

  factory Template.fromJSONString(String templateData) {
    return Template.fromJson(jsonDecode(templateData));
  }

  factory Template.fromJson(Map<String, dynamic> json) {
    return Template(
        (json['stages'] as List).map<Stage>((e) => Stage.fromJson(e)).toList());
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['stages'] = stages.map((e) => e.toJson()).toList();
    return json;
  }
}
