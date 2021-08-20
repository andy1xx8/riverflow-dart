import 'package:riverflow/src/extractors/extractor.dart';
import 'package:riverflow/src/extractors/extractor_types.dart';

class NotNullExtractor extends Extractor {
  NotNullExtractor() : super(ExtractorTypes.IS_NOT_NULL);

  @override
  List extract(dynamic input) {
    return [input].map((e) => e != null).toList();
  }

  factory NotNullExtractor.fromJson(Map<String, dynamic> json) => NotNullExtractor();
}
