import 'dart:convert';

import 'package:riverflow/src/extractors/array_extractor.dart';
import 'package:riverflow/src/extractors/date_extractor.dart';
import 'package:riverflow/src/extractors/extractor_types.dart';
import 'package:riverflow/src/extractors/html_extractor.dart';
import 'package:riverflow/src/extractors/not_null_extractor.dart';
import 'package:riverflow/src/extractors/regex_extractor.dart';
import 'package:riverflow/src/extractors/string_extractor.dart';
import 'package:riverflow/src/extractors/switchcase_extractor.dart';

abstract class Extractor {
  final String type;

  Extractor(this.type);

  List<dynamic> extract(dynamic input);

  factory Extractor.fromJson(Map<String, dynamic> json) {
    final type = json['type'];
    if (type == null) {
      throw FormatException('This is not a valid json for an Extractor: ${jsonEncode(json)}');
    }
    switch (type) {
      case ExtractorTypes.HTML:
        return HtmlExtractor.fromJson(json);
      case ExtractorTypes.HTML_INCLUDE:
        return HtmlIncludeExtractor.fromJson(json);
      case ExtractorTypes.HTML_EXCLUDE:
        return HtmlExcludeExtractor.fromJson(json);
      case ExtractorTypes.HTML_CHANGE_ATTRIBUTE:
        return HtmlAttributeEditor.fromJson(json);
      case ExtractorTypes.HTML_TAG_REMOVAL:
        return HtmlTextExtractor.fromJson(json);
      case ExtractorTypes.HTML_TAG_RENAME:
        return HtmlRenameExtractor.fromJson(json);
      case ExtractorTypes.HTML_DECODER:
        return HtmlDecoderExtractor.fromJson(json);
      case ExtractorTypes.REGEX:
        return RegexExtractor.fromJson(json);
      case ExtractorTypes.FILTER:
        return StringFilterExtractor.fromJson(json);
      case ExtractorTypes.REGEX_REPLACE:
        return RegexReplaceExtractor.fromJson(json);
      case ExtractorTypes.DATETIME_CONVERTER:
        return DateTimeExtractor.fromJson(json);
      case ExtractorTypes.EPOCH_TIME_CONVERTER:
        return EpochTimeExtractor.fromJson(json);
      case ExtractorTypes.STRING_SPLITTER:
        return StringSplitterExtractor.fromJson(json);
      case ExtractorTypes.TRIM:
        return StringTrimExtractor.fromJson(json);
      case ExtractorTypes.REMOVE_EMPTY:
        return StringRemoveEmptyExtractor.fromJson(json);
      case ExtractorTypes.SWITCH_CASE:
        return SwitchCaseExtractor.fromJson(json);
      case ExtractorTypes.IS_NOT_NULL:
        return NotNullExtractor.fromJson(json);
      case ExtractorTypes.ARRAY_REMOVE_FIRST:
        return ArrayRemoveFirstExtractor.fromJson(json);
      case ExtractorTypes.ARRAY_GET:
        return ArrayGetExtractor.fromJson(json);
      default:
        throw UnsupportedError('Unknown extractor type: $type');
    }
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['type'] = type;
    return json;
  }
}
