import 'package:riverflow/src/extractors/extractor.dart';
import 'package:riverflow/src/extractors/extractor_types.dart';
import 'package:riverflow/src/util/html_utils.dart';
import 'package:html/dom.dart' as dom;

class HtmlExtractor extends Extractor {
  final String selector;
  final List<String> collectors;

  HtmlExtractor({
    this.selector,
    this.collectors,
  }) : super(ExtractorTypes.HTML);

  @override
  List extract(dynamic input) {
    return selectMatchingElements(HtmlUtils.formatInputElement(input))
        .map((element) => HtmlUtils.applyCollectors(element, collectors))
        .where((element) => element != null)
        .toList();
  }

  List<dom.Element> selectMatchingElements(dom.Element element) {
    if (selector != null) {
      return element.querySelectorAll(selector);
    } else {
      return [element];
    }
  }

  factory HtmlExtractor.fromJson(Map<String, dynamic> json) {
    return HtmlExtractor(
      selector: json['selector'],
      collectors: json['collectors'].map<String>((e) => e as String).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['selector'] = selector;
    json['collectors'] = collectors;
    return json;
  }
}

class HtmlIncludeExtractor extends Extractor {
  final String selector;

  HtmlIncludeExtractor({
    this.selector,
  }) : super(ExtractorTypes.HTML_INCLUDE);

  @override
  List extract(dynamic input) {
    return selectMatchingElements(HtmlUtils.formatInputElement(input))
        .where((element) => element != null)
        .toList();
  }

  List<dom.Element> selectMatchingElements(dom.Element element) {
    if (selector != null) {
      return element.querySelectorAll(selector);
    } else {
      return [element];
    }
  }

  factory HtmlIncludeExtractor.fromJson(Map<String, dynamic> json) {
    return HtmlIncludeExtractor(
      selector: json['selector']?.toString(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['selector'] = selector;
    return json;
  }
}

class HtmlExcludeExtractor extends Extractor {
  final String selector;

  HtmlExcludeExtractor({
    this.selector,
  }) : super(ExtractorTypes.HTML_EXCLUDE);

  @override
  List extract(dynamic input) {
    return selectMatchingElements(HtmlUtils.formatInputElement(input))
        .where((element) => element != null)
        .toList();
  }

  List<dom.Element> selectMatchingElements(dom.Element element) {
    if (selector != null) {
      element.querySelectorAll(selector).forEach((element) {
        element.remove();
      });
    }
    return [element];
  }

  factory HtmlExcludeExtractor.fromJson(Map<String, dynamic> json) {
    return HtmlExcludeExtractor(
      selector: json['selector'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['selector'] = selector;
    return json;
  }
}

class HtmlAttributeEditor extends Extractor {
  final String selector;
  final Map<String, String> attributes;

  HtmlAttributeEditor({
    this.selector,
    this.attributes,
  }) : super(ExtractorTypes.HTML_CHANGE_ATTRIBUTE);

  @override
  List extract(dynamic input) {
    selectMatchingElements(HtmlUtils.formatInputElement(input)).forEach((element) {
      if (element.attributes != null) {
        final descAttrs = element.attributes?.keys
                ?.where((attr) => attr != null)
                ?.map((attr) => attr as String)
                ?.where((attr) => attributes.containsKey(attr))
                ?.where((attr) => attributes[attr]?.trim()?.isNotEmpty ?? false)
                ?.where((attr) => element.attributes[attr]?.trim()?.isNotEmpty ?? false)
                ?.toList() ??
            [];
        descAttrs.forEach((attr) {
          final srcAttr = attributes[attr];
          element.attributes[srcAttr] = element.attributes[attr];
        });
      }
    });
    return [input];
  }

  List<dom.Element> selectMatchingElements(dom.Element element) {
    if (selector != null) {
      return element.querySelectorAll(selector);
    } else {
      return [element];
    }
  }

  factory HtmlAttributeEditor.fromJson(Map<String, dynamic> json) {
    return HtmlAttributeEditor(
      selector: json['selector']?.toString(),
      attributes:
          (json['attributes'] as Map).map((key, value) => MapEntry<String, String>(key as String, value as String)),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['selector'] = selector;
    json['attributes'] = attributes;
    return json;
  }
}

class HtmlRenameExtractor extends Extractor {
  final String selector;
  final String renameTo;

  HtmlRenameExtractor({
    this.selector,
    this.renameTo,
  }) : super(ExtractorTypes.HTML_TAG_RENAME);

  @override
  List extract(dynamic input) {
    final root = HtmlUtils.formatInputElement(input);
    selectMatchingElements(root).forEach((element) {
      element.replaceWith(HtmlUtils.cloneWithName(element, renameTo));
    });
    return [root];
  }

  List<dom.Element> selectMatchingElements(dom.Element element) {
    if (selector != null) {
      return element.querySelectorAll(selector);
    } else {
      return [element];
    }
  }

  factory HtmlRenameExtractor.fromJson(Map<String, dynamic> json) {
    return HtmlRenameExtractor(
      selector: json['selector']?.toString(),
      renameTo: json['rename_to']?.toString(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['selector'] = selector;
    json['rename_to'] = renameTo;
    return json;
  }
}

class HtmlDecoderExtractor extends Extractor {
  HtmlDecoderExtractor() : super(ExtractorTypes.HTML_DECODE);

  @override
  List extract(dynamic input) {
    final text = HtmlUtils.formatInputElement(input).text.trim();
    return [text];
  }

  factory HtmlDecoderExtractor.fromJson(Map<String, dynamic> json) {
    return HtmlDecoderExtractor();
  }
}

class HtmlTextExtractor extends Extractor {
  HtmlTextExtractor() : super(ExtractorTypes.HTML_TEXT);

  @override
  List extract(dynamic input) {
    final text = HtmlUtils.formatInputElement(input).text.trim();
    return [text];
  }

  factory HtmlTextExtractor.fromJson(Map<String, dynamic> json) {
    return HtmlTextExtractor();
  }
}
