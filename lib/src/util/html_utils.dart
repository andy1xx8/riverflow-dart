import 'dart:collection';

import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:url/url.dart';

class HtmlUtils {
  static final Set<String> URL_IGNORED_PATTERNS = <String>{
    '^mailto:',
    '^javascript:',
    '^#',
  };

  HtmlUtils._();

  static dom.Document resolveDOM(String html, String baseUrl) {
    final document = parser.parse(html, sourceUrl: baseUrl);
    document.querySelectorAll('[href], [src]').forEach((element) {
      final link = element.attributes['href'] ?? element.attributes['src'];
      if (link != null) {
        final resolvedLink = resolveUrl(link, baseUrl);
        if (element.attributes.containsKey('href')) {
          element.attributes['href'] = resolvedLink;
        } else {
          element.attributes['src'] = resolvedLink;
        }
      }
    });
    return document;
  }

  static String resolveUrl(String input, String baseUrl) {
    var resolvedLink = input;
    try {
      final isIgnored = URL_IGNORED_PATTERNS.map((p) => RegExp(p).hasMatch(input)).where((x) => x).isNotEmpty;

      if (!isIgnored) {
        final uri = Url.parse(baseUrl);
        resolvedLink = uri.resolve(input).toString();
      }
    } catch (_) {}
    return resolvedLink;
  }

  static Map<String, String> findAndParseFormElement(dom.Element root, String formCss) {
    return parseFormElement(root.querySelector(formCss));
  }

  static Map<String, String> parseFormElement(dom.Element formElement) {
    if (formElement == null) {
      return <String, String>{};
    } else {
      final entries = formElement
          .querySelectorAll('input[name] , textarea[name]')
          .map<MapEntry<String, String>>((element) {
            final k = element.attributes['name'].trim();
            final v =
                element.attributes.containsKey('value') ? element.attributes['value'].trim() : element.text?.trim();

            return MapEntry<String, String>(k, v);
          })
          .where((entry) => entry.value != null)
          .toList();

      return Map.fromEntries(entries);
    }
  }

  static dom.Element cloneWithName(dom.Element element, String name) {
    final targetElement = dom.Element.tag(name)..attributes = LinkedHashMap.from(element.attributes);
    return _clone(element, targetElement, true);
  }

  static T _clone<T extends dom.Node>(dom.Element sourceElement, T shallowClone, bool deep) {
    if (deep) {
      for (var child in sourceElement.nodes) {
        shallowClone.append(child.clone(true));
      }
    }
    return shallowClone;
  }

  static dom.Element prepareInputElement(dynamic input) {
    if (input is dom.Document) {
      return input.documentElement;
    } else if (input is dom.Element) {
      return input;
    } else if (input is String) {
      final doc = parser.parse(input);
      if (input.contains('<html')) {
        return doc.documentElement;
      } else {
        return doc.body;
      }
    } else {
      return parser.parse(input.toString()).documentElement;
    }
  }

  static String applyCollectors(dom.Element element, List<String> collectors) {
    return collectors
        .map((collector) => applyCollector(element, collector))
        .where((element) => element != null)
        .where((element) => element.isNotEmpty)
        .firstWhere((element) => true, orElse: () => null);
  }

  static String applyCollector(dom.Element element, String collector) {
    final matcher = RegExp('\\\${(@)?(?<name>.+)}').firstMatch(collector);

    if (matcher == null) {
      throw FormatException('the patterns for collector is invalid');
    }
    final isAttribute = matcher.group(1) != null;
    final name = matcher.namedGroup('name');

    if (isAttribute) {
      return element.attributes[name]?.trim();
    }

    switch (name) {
      case 'html()':
        return element.innerHtml;
      case 'outerHtml()':
        return element.outerHtml;
      case 'text()':
        return element.text;
      default:
        return null;
    }
  }
}
