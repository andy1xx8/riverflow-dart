import 'package:html/dom.dart';
import 'package:riverflow/src/extractors/html_extractor.dart';
import 'package:test/test.dart';

void main() {
  group('HTML Extractor tests', () {
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

    test('Get package title show OK', () {
      var extractor = HtmlExtractor(
        selector: 'a[class="mini-list-item-title"]',
        collectors: ['\$\{text()\}'],
      );

      var result = extractor.extract(html);

      expect(result, isNotNull);
      expect(result, isNotEmpty);
      expect(result[0] == 'device_info', isTrue);

      print(result.map((e) => e.toString()).join(','));
    });

    test('Get package description show OK', () {
      var extractor = HtmlExtractor(
        selector: 'div[class="mini-list-item-body"] p[class="mini-list-item-description"]',
        collectors: ['\$\{text()\}'],
      );

      var result = extractor.extract(html);

      expect(result, isNotNull);
      expect(result, isNotEmpty);
      expect(
          result[0] ==
              'Flutter plugin providing detailed information about the device (make, model, etc.), and Android or iOS version the app is running on.',
          isTrue);
      print(result.map((e) => e.toString()).join(','));
    });
  });

  group('HTML Exclude Extractor tests', () {
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

    test('Remove package title show OK', () {
      var extractor = HtmlExcludeExtractor(
        selector: 'a[class="mini-list-item-title"]',
      );

      var result = extractor.extract(html);

      expect(result, isNotNull);
      expect((result[0] as Element).text != 'device_info', isTrue);
      print(result.map((e) => e.toString()).join(','));
    });

    test('Get package description show OK', () {
      var extractor = HtmlExtractor(
        selector: 'div[class="mini-list-item-body"] p[class="mini-list-item-description"]',
        collectors: ['\$\{text()\}'],
      );

      var result = extractor.extract(html);

      expect(result, isNotNull);
      expect(result, isNotEmpty);
      expect(
          result[0] ==
              'Flutter plugin providing detailed information about the device (make, model, etc.), and Android or iOS version the app is running on.',
          isTrue);
      print(result.map((e) => e.toString()).join(','));
    });
  });
}
