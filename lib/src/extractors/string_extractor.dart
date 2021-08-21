import 'package:riverflow/src/extractors/collector.dart';
import 'package:riverflow/src/extractors/extractor.dart';
import 'package:riverflow/src/extractors/extractor_types.dart';
import 'package:riverflow/src/extractors/filter.dart';
import 'package:riverflow/src/selector/field_selector.dart';
import 'package:html/dom.dart' as dom;

class StringTrimExtractor extends Extractor {
  StringTrimExtractor() : super(ExtractorTypes.TRIM);

  @override
  List extract(input) {
    final inputSource = prepareInputSource(input);

    return [inputSource].where((element) => element != null).map((e) => e?.trim()).toList();
  }

  factory StringTrimExtractor.fromJson(Map<String, dynamic> json) {
    return StringTrimExtractor();
  }

  static String prepareInputSource(dynamic input) {
    if (input is dom.Element) {
      return input.outerHtml.trim();
    } else if (input is String) {
      return input.trim();
    } else {
      return input.toString().trim();
    }
  }
}

class StringRemoveEmptyExtractor extends Extractor {
  StringRemoveEmptyExtractor() : super(ExtractorTypes.REMOVE_EMPTY);

  @override
  List extract(input) {
    final inputSource = StringTrimExtractor.prepareInputSource(input);

    return [inputSource].where((element) => element != null).where((element) => element.isNotEmpty).toList();
  }

  factory StringRemoveEmptyExtractor.fromJson(Map<String, dynamic> json) {
    return StringRemoveEmptyExtractor();
  }
}

class StringSplitterExtractor extends Extractor {
  final String delimiter;
  final String collectType;

  ExtractorCollector collector;

  StringSplitterExtractor({
    this.delimiter,
    this.collectType = CollectTypes.FIRST,
  }) : super(ExtractorTypes.STRING_SPLITTER) {
    collector = ExtractorCollector(collectType, OutputTypes.STRING, null);
  }

  @override
  List extract(input) {
    final fields = StringTrimExtractor.prepareInputSource(input)
        .split(RegExp(delimiter))
        .where((element) => element != null)
        .toList();
    return collector.collectOutput(fields);
  }

  factory StringSplitterExtractor.fromJson(Map<String, dynamic> json) {
    return StringSplitterExtractor(
      delimiter: json['delimiter'],
      collectType: json['collect_type'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['delimiter'] = delimiter;
    json['collect_type'] = collectType;
    return json;
  }
}

class StringFilterExtractor extends Extractor {
  final Filter filter;

  StringFilterExtractor(this.filter) : super(ExtractorTypes.FILTER);

  @override
  List extract(input) {
    final inputSource = prepareInputSource(input);

    return [inputSource].where((element) => filter.isMatch(element)).toList();
  }

  factory StringFilterExtractor.fromJson(Map<String, dynamic> json) {
    return StringFilterExtractor(
      Filter.fromJson(json['filter']),
    );
  }

  static String prepareInputSource(dynamic input) {
    if (input is dom.Element) {
      return input.outerHtml.trim();
    } else if (input is String) {
      return input.trim();
    } else {
      return input.toString().trim();
    }
  }
}

