import 'package:html/dom.dart' as dom;
import 'package:riverflow/src/extractors/extractor.dart';
import 'package:riverflow/src/extractors/extractor_types.dart';
import 'package:riverflow/src/util/html_utils.dart';

class HtmlExtractor extends Extractor {
  final String? selector;
  final List<String> collectors;
  final int maxCount;

  HtmlExtractor({
    this.selector,
    required this.collectors,
    this.maxCount = 0,
  }) : super(ExtractorTypes.HTML);

  @override
  List extract(dynamic input) {
    return HtmlUtils.selectMatchingElements(
      HtmlUtils.formatInputElement(input),
      selector,
      maxCount,
    ).map((element) => HtmlUtils.applyCollectors(element, collectors)).where((element) => element != null).toList();
  }

  factory HtmlExtractor.fromJson(Map<String, dynamic> json) {
    return HtmlExtractor(
      selector: json['selector'],
      collectors: json['collectors'].map<String>((e) => e as String).toList(),
      maxCount: json.containsKey('max_count') ? (json['max_count'] as int) : 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['selector'] = selector;
    json['collectors'] = collectors;
    json['max_count'] = maxCount;
    return json;
  }
}

class HtmlIncludeExtractor extends Extractor {
  final String? selector;
  final int maxCount;

  HtmlIncludeExtractor({
    required this.selector,
    this.maxCount = 0,
  }) : super(ExtractorTypes.HTML_INCLUDE);

  @override
  List extract(dynamic input) {
    return HtmlUtils.selectMatchingElements(
      HtmlUtils.formatInputElement(input),
      selector,
      maxCount,
    );
  }

  factory HtmlIncludeExtractor.fromJson(Map<String, dynamic> json) {
    return HtmlIncludeExtractor(
      selector: json['selector']?.toString(),
      maxCount: json.containsKey('max_count') ? (json['max_count'] as int) : 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['selector'] = selector;
    json['max_count'] = maxCount;
    return json;
  }
}

class HtmlExcludeExtractor extends Extractor {
  final String? selector;
  final int maxCount;

  HtmlExcludeExtractor({
    this.selector,
    this.maxCount = 0,
  }) : super(ExtractorTypes.HTML_EXCLUDE);

  @override
  List extract(dynamic input) {
    return selectMatchingElements(HtmlUtils.formatInputElement(input)).toList();
  }

  List<dom.Element> selectMatchingElements(dom.Element? element) {
    if (element == null) {
      return [];
    }
    if (selector == null) {
      return [element];
    }

    if (maxCount > 1 || maxCount <= 0) {
      element.querySelectorAll(selector!).forEach((element) {
        element.remove();
      });
    } else {
      [element.querySelector(selector!)].where((element) => element != null).map((e) => e!).toList().forEach((element) {
        element.remove();
      });
    }
    return [element];
  }

  factory HtmlExcludeExtractor.fromJson(Map<String, dynamic> json) {
    return HtmlExcludeExtractor(
      selector: json['selector'],
      maxCount: json.containsKey('max_count') ? (json['max_count'] as int) : 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['selector'] = selector;
    json['max_count'] = maxCount;
    return json;
  }
}

class HtmlAttributeEditor extends Extractor {
  final String? selector;
  final Map<String, String> attributes;
  final int maxCount;

  HtmlAttributeEditor({
    this.selector,
    required this.attributes,
    this.maxCount = 0,
  }) : super(ExtractorTypes.HTML_CHANGE_ATTRIBUTE);

  @override
  List extract(dynamic input) {
    selectMatchingElements(HtmlUtils.formatInputElement(input)).forEach((element) {
      final descAttrs = element.attributes.keys
          .map((name) => name as String)
          .where((attr) => attributes.containsKey(attr) && attributes[attr] != null)
          .where((attr) => attributes[attr]!.trim().isNotEmpty)
          .where((attr) => element.attributes[attr]!.trim().isNotEmpty)
          .toList();
      descAttrs.forEach((attr) {
        final srcAttr = attributes[attr]!;
        element.attributes[srcAttr] = element.attributes[attr]!;
      });
    });
    return [input];
  }

  List<dom.Element> selectMatchingElements(dom.Element? element) {
    if (element == null) return [];
    if (selector == null) return [element];

    return (maxCount > 1)
        ? element.querySelectorAll(selector!)
        : [element.querySelector(selector!)].where((element) => element != null).map((e) => e!).toList();
  }

  factory HtmlAttributeEditor.fromJson(Map<String, dynamic> json) {
    return HtmlAttributeEditor(
      selector: json['selector']?.toString(),
      attributes:
          (json['attributes'] as Map).map((key, value) => MapEntry<String, String>(key as String, value as String)),
      maxCount: json.containsKey('max_count') ? (json['max_count'] as int) : 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['selector'] = selector;
    json['attributes'] = attributes;
    json['max_count'] = maxCount;
    return json;
  }
}

class HtmlRenameExtractor extends Extractor {
  final String? selector;
  final String renameTo;
  final int maxCount;

  HtmlRenameExtractor({
    this.selector,
    required this.renameTo,
    this.maxCount = 0,
  }) : super(ExtractorTypes.HTML_TAG_RENAME);

  @override
  List extract(dynamic input) {
    final rootElement = HtmlUtils.formatInputElement(input);
    selectMatchingElements(rootElement).forEach((element) {
      element.replaceWith(HtmlUtils.cloneWithName(element, renameTo));
    });
    return [rootElement];
  }

  List<dom.Element> selectMatchingElements(dom.Element? element) {
    if (element == null) return [];
    if (selector == null) return [element];

    return (maxCount > 1)
        ? element.querySelectorAll(selector!)
        : [element.querySelector(selector!)].where((element) => element != null).map((e) => e!).toList();
  }

  factory HtmlRenameExtractor.fromJson(Map<String, dynamic> json) {
    return HtmlRenameExtractor(
      selector: json['selector']?.toString(),
      renameTo: json['rename_to'].toString(),
      maxCount: json.containsKey('max_count') ? (json['max_count'] as int) : 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['selector'] = selector;
    json['rename_to'] = renameTo;
    json['max_count'] = maxCount;
    return json;
  }
}

class HtmlDecoderExtractor extends Extractor {
  HtmlDecoderExtractor() : super(ExtractorTypes.HTML_DECODE);

  @override
  List extract(dynamic input) {
    final text = HtmlUtils.formatInputElement(input)?.text.trim();
    return [text].where((element) => element != null).map((e) => e!).toList();
  }

  factory HtmlDecoderExtractor.fromJson(Map<String, dynamic> json) {
    return HtmlDecoderExtractor();
  }
}

class HtmlTextExtractor extends Extractor {
  HtmlTextExtractor() : super(ExtractorTypes.HTML_TEXT);

  @override
  List extract(dynamic input) {
    final text = HtmlUtils.formatInputElement(input)?.text.trim();
    return [text].where((element) => element != null).map((e) => e!).toList();
  }

  factory HtmlTextExtractor.fromJson(Map<String, dynamic> json) {
    return HtmlTextExtractor();
  }
}
