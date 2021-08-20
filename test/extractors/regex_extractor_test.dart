import 'package:riverflow/src/extractors/regex_extractor.dart';
import 'package:test/test.dart';

void main() {
  group('Regex Extractor tests', () {
    var html = '''
      <div class="mini-list-item">
        <a class="mini-list-item-title" href="/packages/device_info"><h3>device_info</h3></a>
        <div class="mini-list-item-body">
          <p class="mini-list-item-description">Flutter plugin providing detailed information about the device (make, model, etc.), and Android or iOS version the app is running on.</p>
        </div>
        <div class="mini-list-item-footer">
            <div class="mini-list-item-publisher">
              <img class="publisher-badge" src="/static/img/verified-publisher-gray.svg?hash=je610l58nj7vkvrdmrhakp3npkle6iol" title="Published by a pub.dev verified publisher">
              <a class="publisher-link" href="/publishers/flutter.dev">flutter.dev</a>
            </div>
        </div>
      </div>
      ''';

    test('Get package href should OK', () {

      var extractor = RegexExtractor(
        selectors: [
          'href="(?<href>.+)"',
        ],
        outputGroup: 'href',
      );

      var result = extractor.extract(html);

      expect(result, isNotNull);
      expect(result, isNotEmpty);
      expect(result[0] == '/packages/device_info', isTrue);
    });

    test('Get image src should OK', () {
      var extractor = RegexExtractor(
        selectors: [
          'src="(?<src>.+)"',
        ],
        outputGroup: 'src',
      );

      var result = extractor.extract(html);

      expect(result, isNotNull);
      expect(result, isNotEmpty);
      expect((result[0] as String).contains('/static/img/verified-publisher-gray.svg'), isTrue);
    });

  });


  group('Regex replace Extractor tests', () {

    test('Replace package href should OK', () {
      var html = 'href="/packages/device_info"';
      var extractor = RegexReplaceExtractor(
        selectors: [
          'href="(?<href>.+)"',
        ],
        replacement: 'replace_value',
      );

      var result = extractor.extract(html);

      result.forEach((element) => print(element));
      expect(result, isNotNull);
      expect(result, isNotEmpty);
      expect(result[0] == 'replace_value', isTrue);
    });

    test('Replace image src should OK', () {
      var html = 'src="/static/img/verified-publisher-gray.svg?hash=je610l58nj7vkvrdmrhakp3npkle6iol"';
      var extractor = RegexReplaceExtractor(
        selectors: [
          'src="(?<src>.+)"',
        ],
        replacement: 'src',
      );

      var result = extractor.extract(html);

      expect(result, isNotNull);
      expect(result, isNotEmpty);
      expect(result[0] == 'src', isTrue);
    });


  });
}
