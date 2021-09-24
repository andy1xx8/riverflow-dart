import 'package:html/dom.dart' as dom;
import 'package:riverflow/src/extractors/extractor.dart';
import 'package:riverflow/src/extractors/extractor_types.dart';

class SwitchCaseExtractor extends Extractor {
  final Map<String, String> options;
  final dynamic defaultValue;

  SwitchCaseExtractor({
    required this.options,
    this.defaultValue,
  }) : super(ExtractorTypes.SWITCH_CASE);

  @override
  List extract(input) {
    final inputSource = prepareInputSource(input);
    if (inputSource == null) return [];
    return [options[inputSource] ?? defaultValue].where((element) => element != null).toList();
  }

  factory SwitchCaseExtractor.fromJson(Map<String, dynamic> json) {
    return SwitchCaseExtractor(
      options: (json['options'] as Map).map((key, value) => MapEntry(key, value)),
      defaultValue: json['default_value'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['options'] = options;
    json['default_value'] = defaultValue;
    return json;
  }

  static String? prepareInputSource(dynamic input) {
    if (input is dom.Element) {
      return input.outerHtml.trim();
    } else if (input is String) {
      return input.trim();
    } else {
      return input?.toString().trim();
    }
  }
}
