import 'dart:convert';

import 'package:riverflow/src/extractors/array_extractor.dart';
import 'package:riverflow/src/extractors/date_extractor.dart';
import 'package:riverflow/src/extractors/extractor_types.dart';
import 'package:riverflow/src/extractors/html_extractor.dart';
import 'package:riverflow/src/extractors/not_null_extractor.dart';
import 'package:riverflow/src/extractors/regex_extractor.dart';
import 'package:riverflow/src/extractors/string_extractor.dart';
import 'package:riverflow/src/extractors/switchcase_extractor.dart';

/// Subclasses of this class implement different kinds of extractors.
/// The most common kinds of extractors are:
///
/// * HtmlExtractor.
///   An extractor to select a html element, document or event a html string
///   and then extract desire data by using CSS-Selector syntax.
///
/// * HtmlIncludeExtractor.
///   An extractor to select element from a html element, document or event a html string
///   by using CSS-Selector syntax.
///
/// * HtmlExcludeExtractor.
///   An extractor to exclude element from a html element, document or event a html string
///   by using CSS-Selector syntax.
///
/// * HtmlAttributeEditor.
///   An extractor to change HTML's tag attributes of a html element, document or event a html string
///   by using CSS-Selector syntax.
///
/// * HtmlRenameExtractor.
///   An extractor to rename HTML's tag
///
/// * HtmlDecoderExtractor.
///   Decode HTML special characters.
///
/// * NotNullExtractor.
///   An extractor to check if an element is NULL.
///
/// * RegexExtractor.
///   An extractor to extract data using Regular Expression.
///
/// * RegexReplaceExtractor.
///   An extractor to replace a string using Regular Expression.
///
/// * StringTrimExtractor.
///   An extractor to trim a string.
///
/// * StringRemoveEmptyExtractor.
///   An extractor to remove all NULL and empty string.
///
/// * StringSplitterExtractor.
///   An extractor to split a string into a list.
///
/// * StringFilterExtractor.
///   An extractor to filter out unnecessary items.
///
/// * SwitchCaseExtractor.
///   An extractor to transform a value to others using switch-case expression.
///
/// * DateTimeExtractor.
///   An extractor to extract a date time string to DateTime.
///
/// * EpochTimeExtractor.
///   An extractor to convert date time to Unix epoch milliseconds.
abstract class Extractor {
  final String type;

  Extractor(this.type);

  /// Process `input` and extract necessary data.
  ///
  /// * Note: the output is usually passed to the next [extractor] in the chain.
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
      case ExtractorTypes.HTML_CONTAINS:
        return HtmlContainsExtractor.fromJson(json);
      case ExtractorTypes.HTML_CHANGE_ATTRIBUTE:
        return HtmlAttributeEditor.fromJson(json);
      case ExtractorTypes.HTML_TAG_RENAME:
        return HtmlRenameExtractor.fromJson(json);
      case ExtractorTypes.HTML_TEXT:
        return HtmlTextExtractor.fromJson(json);
      case ExtractorTypes.HTML_DECODE:
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
      case ExtractorTypes.REMOVE_EMPTY_STRING:
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
