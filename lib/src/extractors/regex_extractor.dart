import 'package:riverflow/src/extractors/extractor.dart';
import 'package:riverflow/src/extractors/extractor_types.dart';
import 'package:html/dom.dart' as dom;

class RegexExtractor extends Extractor {
  final List<String> selectors;
  final String outputGroup;

  final List<RegExp> _regExpList = [];
  RegexExtractor({
    this.selectors,
    this.outputGroup,
  }) : super(ExtractorTypes.REGEX) {
    selectors.forEach((pattern) {
      _regExpList.add(RegExp(pattern));
    });
  }

  @override
  List extract(input) {
    final inputSource = RegexExtractor.prepareInputSource(input);

    return _regExpList
        .map((regExp) => regExp.allMatches(inputSource))
        .where((matches) => matches.isNotEmpty)
        .expand((matches) => matches)
        .map((match) => match.namedGroup(outputGroup))
        .where((element) => element != null)
        .toList();
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

class RegexReplaceExtractor extends Extractor {
  final List<String> selectors;
  final String replacement;

  RegexReplaceExtractor({
    this.selectors,
    this.replacement,
  }) : super(ExtractorTypes.REGEX_REPLACE);

  @override
  List extract(input) {
    final inputSource = RegexExtractor.prepareInputSource(input);
    final output = selectors.fold(inputSource, (outputResult, selector) {
      return outputResult.replaceAll(RegExp(selector), replacement);
    });
    return [output];
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
