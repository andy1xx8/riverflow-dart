import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverflow/riverflow.dart';
import 'package:test/test.dart';

void main() {
  var html = '';
  test('Get html from Pub Dev favorites should OK', () async {
    var response =
        await http.get(Uri.parse('https://pub.dev/flutter/favorites'));
    expect(response, isNotNull);
    expect(response.body, isNotEmpty);
    html = response.body;
  });

  test('Parse Pub Dev favorites should OK', () {
    var stage1 = DomStage(
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
          collectAs: SingleFieldCollector(
              CollectTypes.ARRAY, OutputTypes.HTML_ELEMENT, null),
        ),
      },
      excludeMapping: {
        '/_body',
      },
    );
    var stage2 = DomStage(
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
            HtmlExtractor(
                selector: 'h3[class="packages-title"]',
                collectors: ['\${text()}']),
            StringTrimExtractor(),
          ],
        ),
        'description': FieldSelector(
          extractors: [
            HtmlExtractor(
                selector: 'p[class="packages-description"]',
                collectors: ['\${text()}'])
          ],
        ),
        'likes': FieldSelector(
          extractors: [
            HtmlExtractor(
                selector:
                    'div[class*="packages-score-like"] *[class="packages-score-value-number"]',
                collectors: ['\${text()}'])
          ],
          collectAs:
              SingleFieldCollector(CollectTypes.FIRST, OutputTypes.INT, 0),
        ),
        'health': FieldSelector(
          extractors: [
            HtmlExtractor(
                selector:
                    'div[class*="packages-score-health"] *[class="packages-score-value-number"]',
                collectors: ['\${text()}']),
          ],
          collectAs:
              SingleFieldCollector(CollectTypes.FIRST, OutputTypes.INT, 0),
        ),
        'popularity': FieldSelector(
          extractors: [
            HtmlExtractor(
                selector:
                    'div[class*="packages-score-popularity"] *[class="packages-score-value-number"]',
                collectors: ['\${text()}']),
          ],
        ),
      },
      excludeMapping: {
        '/package_html',
      },
    );

    var flow = WebFlow(Template([stage1, stage2]));

    var records =
        flow.start([html.asDocument('https://pub.dev').documentElement!]);
    expect(records, isNotEmpty);
    expect(records[0], isNotNull);

    print(jsonEncode(records.map((record) => record.toJson()).toList()));
  });
}
