import 'package:riverflow/src/extractors/html_extractor.dart';
import 'package:test/test.dart';

void main() {
  group('Extractor serializers tests', () {

    test('Serialize html extractor should OK', () {
      var extractor = HtmlExtractor(
        selector: 'div[class="threads"] h1[class="title"]',
        collectors: [
          '\${text()}'
        ]
      );

      var result = extractor.toJson();

      expect(result, isNotNull);
      expect(result, isNotEmpty);
      expect(result, {
        'type': 'html',
        'selector': 'div[class="threads"] h1[class="title"]',
        'collectors': ['\${text()}'],
      });

      print(result);
    });
  });
}
