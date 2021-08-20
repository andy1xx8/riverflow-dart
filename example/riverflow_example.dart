import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverflow/riverflow.dart';

void main() async {
  final stage1 = DomStage(
    inputMapping: {
      'package_html': '/_body',
    },
    outputFields: {
      'package_html': FieldSelector(
        extractors: [
          HtmlIncludeExtractor(
            selector: 'div[class="packages"] div[class="packages-item"]',
          )
        ],
        isFlatten: true,
        collectAs: DefaultCollector(CollectTypes.ARRAY, OutputTypes.HTML_ELEMENT, null),
      ),
    },
    excludeMapping: {
      '/_body',
    },
  );
  final stage2 = DomStage(
    inputMapping: {
      'package_name': '/package_html',
      'description': '/package_html',
      'likes': '/package_html',
      'health': '/package_html',
      'popularity': '/package_html',
    },
    outputFields: {
      'package_name': FieldSelector(
        extractors: [
          HtmlExtractor(selector: 'h3[class="packages-title"]', collectors: ['\${text()}']),
          StringTrimExtractor(),
        ],
      ),
      'description': FieldSelector(
        extractors: [
          HtmlExtractor(selector: 'p[class="packages-description"]', collectors: ['\${text()}'])
        ],
      ),
      'likes': FieldSelector(
        extractors: [
          HtmlExtractor(
              selector: 'div[class*="packages-score-like"] *[class="packages-score-value-number"]',
              collectors: ['\${text()}'])
        ],
        collectAs: DefaultCollector(CollectTypes.FIRST, OutputTypes.INT, 0),
      ),
      'health': FieldSelector(
        extractors: [
          HtmlExtractor(
              selector: 'div[class*="packages-score-health"] *[class="packages-score-value-number"]',
              collectors: ['\${text()}']),
        ],
        collectAs: DefaultCollector(CollectTypes.FIRST, OutputTypes.INT, 0),
      ),
      'popularity': FieldSelector(
        extractors: [
          HtmlExtractor(
              selector: 'div[class*="packages-score-popularity"] *[class="packages-score-value-number"]',
              collectors: ['\${text()}']),
        ],
      ),
    },
    excludeMapping: {
      '/package_html',
    },
  );

  final flow = WebFlow([stage1, stage2]);

  final response = await http.get('https://pub.dev/flutter/favorites');
  final html = response.body;

  var records = flow.startFloating([html.asDocument('https://pub.dev').documentElement]);

  records.forEach((record) {
    print(jsonEncode(record.toJson()));
    print('--------------------------\n');
  });
}
