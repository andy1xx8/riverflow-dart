import 'dart:convert';

import 'package:test/test.dart';
import '../data/f21.html.dart';
import '../data/home.html.dart';
import 'template_tester.dart';

void main() {
  final baseUrl = 'https://voz.vn';

  test('Parse boxes in Homepage should OK', () async {
    final tester = TemplateTester('test/data/template_boxes_list.json', 'https://voz.vn');
    final records = await tester.testHtml(home, baseUrl);
    expect(records, isNotEmpty);
    expect(records[0], isNotNull);

    records.forEach((record) {
      print(jsonEncode(record.toJson()));
      print('----\n');
    });
  });

  test('Parse sub boxes in App di dong should OK', () async {
    final tester = TemplateTester('test/data/template_boxes_list.json', 'https://voz.vn/f/app-di-dong.21/');
    final records = await tester.testHtml(f21, baseUrl);
    expect(records, isNotEmpty);
    expect(records[0], isNotNull);

    records.forEach((record) {
      print(jsonEncode(record.toJson()));
      print('----\n');
    });
  });
}
