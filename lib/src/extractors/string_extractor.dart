import 'package:html/dom.dart' as dom;
import 'package:riverflow/src/extractors/collector.dart';
import 'package:riverflow/src/extractors/extractor.dart';
import 'package:riverflow/src/extractors/extractor_types.dart';
import 'package:riverflow/src/extractors/filter.dart';
import 'package:riverflow/src/selector/field_selector.dart';

class StringTrimExtractor extends Extractor {
  StringTrimExtractor() : super(ExtractorTypes.TRIM);

  @override
  List extract(input) {
    final inputSource = prepareInputSource(input);
    if (inputSource == null) {
      return [];
    } else {
      return [inputSource].map((e) => e.trim()).toList();
    }
  }

  factory StringTrimExtractor.fromJson(Map<String, dynamic> json) {
    return StringTrimExtractor();
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

class StringRemoveEmptyExtractor extends Extractor {
  StringRemoveEmptyExtractor() : super(ExtractorTypes.REMOVE_EMPTY_STRING);

  @override
  List extract(input) {
    final inputSource = StringTrimExtractor.prepareInputSource(input);

    if (inputSource == null) return [];

    return [inputSource].where((element) => element.isNotEmpty).toList();
  }

  factory StringRemoveEmptyExtractor.fromJson(Map<String, dynamic> json) {
    return StringRemoveEmptyExtractor();
  }
}

class StringSplitterExtractor extends Extractor {
  final String delimiter;
  final String collectType;

  late final ArrayFieldCollector collector;

  StringSplitterExtractor({
    required this.delimiter,
    this.collectType = CollectTypes.FIRST,
  }) : super(ExtractorTypes.STRING_SPLITTER) {
    collector = ArrayFieldCollector(collectType, OutputTypes.STRING, null);
  }

  @override
  List extract(input) {
    final source = StringTrimExtractor.prepareInputSource(input);
    if(source == null) {
      return [];
    }
    final fields = source
        .split(RegExp(delimiter))
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
