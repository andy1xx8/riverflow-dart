import 'dart:convert';

import 'package:html/dom.dart';
import 'package:riverflow/src/util/extensions.dart';
import 'package:test/test.dart';

import '../data/f68_page14.dart';
import 'template_tester.dart';

void main() {
  final boxUrl = 'https://voz.vn/f/68/page-14';

  late final Document dom;

  test('load html', () {
    dom = f68_page14.asDocument('https://voz.vn');
  });

  test('Parse metadata should OK', () async {
    final tester = TemplateTester('test/data/template_box_metadata.json', boxUrl);
    final records = await tester.testDocument(dom);
    expect(records, isNotEmpty);
    expect(records[0], isNotNull);

    records.forEach((record) {
      print(jsonEncode(record.toJson()));
      print('----\n');
    });
  });

  test('Parse prefixes should OK', () async {
    final tester = TemplateTester('test/data/template_box_prefixes.json', boxUrl);
    final records = await tester.testDocument(dom);
    expect(records, isNotEmpty);
    expect(records[0], isNotNull);

    records.forEach((record) {
      print(jsonEncode(record.toJson()));
      print('----\n');
    });
  });

  test('Parse create thread form should OK', () async {
    final tester = TemplateTester('test/data/template_box_create_thread_form.json', boxUrl);
    final records = await tester.testDocument(dom);
    expect(records, isNotEmpty);
    expect(records[0], isNotNull);

    records.forEach((record) {
      print(jsonEncode(record.toJson()));
      print('----\n');
    });
  });

  test('Parse sub boxes should Empty', () async {
    final tester = TemplateTester('test/data/template_boxes_list.json', boxUrl);
    final records = await tester.testDocument(dom);

    records.forEach((element) {
      print(element);
    });
    expect(records, isEmpty);
  });

  test('Parse threads should OK', () async {
    final tester = TemplateTester('test/data/template_thread_list.json', boxUrl);
    final records = await tester.testDocument(dom);
    expect(records, isNotEmpty);
    expect(records[0], isNotNull);

    records.forEach((record) {
      print(jsonEncode(record.toJson()));
      print('----\n');
    });
  });
}
