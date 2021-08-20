import 'dart:convert';

import 'package:test/test.dart';

import '../data/search.html.dart';
import 'template_tester.dart';

void main() {
  final baseUrl = 'https://voz.vn';
  final boxUrl = 'https://voz.vn/search/455664/?page=2&q=nextVoz&o=relevance';

  test('Parse search metadata should OK', () async {
    final tester = TemplateTester('test/data/template_search_metadata.json', boxUrl);
    final records = await tester.testHtml(search, baseUrl);
    expect(records, isNotEmpty);
    expect(records[0], isNotNull);

    records.forEach((record) {
      print(jsonEncode(record.toJson()));
      print('----\n');
    });
  });

  test('Parse search results should OK', () async {
    final tester = TemplateTester('test/data/template_search_result.json', boxUrl);
    final records = await tester.testHtml(search, baseUrl);
    expect(records, isNotEmpty);
    expect(records[0], isNotNull);

    records.forEach((record) {
      print(jsonEncode(record.toJson()));
      print('----\n');
    });
  });
}
