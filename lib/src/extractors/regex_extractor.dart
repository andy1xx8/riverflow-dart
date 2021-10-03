import 'package:html/dom.dart' as dom;
import 'package:riverflow/src/extractors/extractor.dart';
import 'package:riverflow/src/extractors/extractor_types.dart';

class RegexExtractor extends Extractor {
  final List<String> selectors;
  final String outputGroup;

  final List<RegExp> _regExpList = [];

  RegexExtractor({
    required this.selectors,
    required this.outputGroup,
  }) : super(ExtractorTypes.REGEX) {
    selectors.forEach((pattern) {
      _regExpList.add(RegExp(pattern));
    });
  }

  @override
  List extract(input) {
    final inputSource = RegexExtractor.prepareInputSource(input);

    if (inputSource == null) {
      return [];
    } else {
      return _regExpList
          .map((regExp) => regExp.allMatches(inputSource))
          .where((matches) => matches.isNotEmpty)
          .expand((matches) => matches)
          .map((match) => match.namedGroup(outputGroup))
          .where((element) => element != null)
          .toList();
    }
  }

  factory RegexExtractor.fromJson(Map<String, dynamic> json) {
    return RegexExtractor(
      selectors: json['selectors'].map<String>((e) => e as String).toList(),
      outputGroup: json['output_group'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['selectors'] = selectors;
    json['output_group'] = outputGroup;
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

class RegexReplaceExtractor extends Extractor {
  final List<String> selectors;
  final String replacement;

  RegexReplaceExtractor({
    required this.selectors,
    required this.replacement,
  }) : super(ExtractorTypes.REGEX_REPLACE);

  @override
  List extract(input) {
    final inputSource = RegexExtractor.prepareInputSource(input);
    if (inputSource == null) {
      return [];
    } else {
      final output = selectors.fold<String>(inputSource, (outputResult, selector) {
        return outputResult.replaceAll(RegExp(selector), replacement);
      });
      return [output];
    }
  }

  factory RegexReplaceExtractor.fromJson(Map<String, dynamic> json) {
    return RegexReplaceExtractor(
      selectors: json['selectors'].map<String>((e) => e as String).toList(),
      replacement: json['replacement'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['selectors'] = selectors;
    json['replacement'] = replacement;
    return json;
  }
}

class RegexMatchExtractor extends Extractor {
  final List<String> selectors;
  final List<RegExp> _regExpList = [];

  RegexMatchExtractor({
    required this.selectors,
  }) : super(ExtractorTypes.REGEX_MATCH) {
    selectors.forEach((pattern) {
      _regExpList.add(RegExp(pattern));
    });
  }

  @override
  List extract(input) {
    final inputSource = RegexExtractor.prepareInputSource(input);

    if (inputSource == null) {
      return [];
    } else {
      final hasMatch = _regExpList.where((regExp) => regExp.hasMatch(inputSource)).isNotEmpty;
      return hasMatch ? [inputSource] : [];
    }
  }

  factory RegexMatchExtractor.fromJson(Map<String, dynamic> json) {
    return RegexMatchExtractor(
      selectors: json['selectors'].map<String>((e) => e as String).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['selectors'] = selectors;
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
