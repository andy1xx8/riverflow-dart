import 'dart:convert';

import 'package:test/test.dart';

import '../data/f33.html.dart';
import '../data/newpost.html.dart';
import 'template_tester.dart';

void main() {
  final baseUrl = 'https://voz.vn';

  group('Parse Threads', () {
    test('in Diem bao F33 should OK', () async {
      final tester = TemplateTester('test/data/template_thread_list.json',
          'https://voz.vn/f/diem-bao.33/');
      final records = await tester.testHtml(f33, baseUrl);
      expect(records, isNotEmpty);
      expect(records[0], isNotNull);

      records.forEach((record) {
        print(jsonEncode(record.toJson()));
        print('----\n');
      });
    });

    test('in What"s New > New Posts should OK', () async {
      final tester = TemplateTester('test/data/template_thread_list.json',
          'https://voz.vn/whats-new/posts/');
      final records = await tester.testHtml(newposts, baseUrl);
      expect(records, isNotEmpty);
      expect(records[0], isNotNull);

      records.forEach((record) {
        print(jsonEncode(record.toJson()));
        print('----\n');
      });
    });
  });
}
