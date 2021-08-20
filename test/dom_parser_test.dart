import 'dart:convert';

import 'package:riverflow/riverflow.dart';
import 'package:riverflow/src/dom_stage.dart';
import 'package:riverflow/src/extractors/html_extractor.dart';
import 'package:riverflow/src/extractors/regex_extractor.dart';
import 'package:riverflow/src/selector/field_selector.dart';
import 'package:test/test.dart';

void main() {
  test('Parse Pub Dev favorites should OK', () {
    var stage = DomStage(
      inputMapping: {
        'package_name': '/_body',
        'description': '/_body',
        'publisher': '/_body',
        'publisher_link': '/_body',
      },
      outputFields: {
        'package_name': FieldSelector(
          extractors: [
            HtmlExtractor(selector: 'a[class="mini-list-item-title"]', collectors: ['\${text()}'])
          ],
        ),
        'description': FieldSelector(
          extractors: [
            HtmlExtractor(selector: 'p[class="mini-list-item-description"]', collectors: ['\${text()}'])
          ],
        ),
        'publisher': FieldSelector(
          extractors: [
            HtmlExtractor(selector: 'a[class="publisher-link"]', collectors: ['\${text()}'])
          ],
        ),
        'publisher_link': FieldSelector(
          extractors: [
            HtmlExtractor(selector: 'a[class="publisher-link"]', collectors: ['\${@href}']),
            RegexReplaceExtractor(
              selectors: ['^'],
              replacement: 'https://pub.dev',
            )
          ],
        ),
      },
      excludeMapping: {
        '/_body',
      },
    );

    var record = Record.fromMap({
      '_body': '''<div class="mini-list-item">
    <a class="mini-list-item-title" href="/packages/redux"><h3>redux</h3></a>
    <div class="mini-list-item-body">
      <p class="mini-list-item-description">Redux is a predictable state container for Dart and Flutter apps</p>
    </div>
    <div class="mini-list-item-footer">
        <div class="mini-list-item-publisher">
          <img class="publisher-badge" src="/static/img/verified-publisher-gray.svg?hash=je610l58nj7vkvrdmrhakp3npkle6iol" title="Published by a pub.dev verified publisher">
          <a class="publisher-link" href="/publishers/fluttercommunity.dev">fluttercommunity.dev</a>
        </div>
    </div>
  </div>'''
    });

    var records = stage.process(record);

    expect(records, isNotEmpty);
    expect(records[0], isNotNull);

    print(jsonEncode(records[0]));
  });

  test('Rename HTML Tag should OK', () {
    var stage = DomStage(inputMapping: {
      'package_name': '/_body',
      'description': '/_body',
      'publisher': '/_body',
      'publisher_link': '/_body',
    }, outputFields: {
      'description': FieldSelector(
        extractors: [
          HtmlRenameExtractor(
            // selector: 'a[class="publisher-link"]',
            selector: 'div[class="mini-list-item"]',
            renameTo: 'blockquote',
          )
        ],
      )
    }, excludeMapping: {
      '/_body',
    });

    var record = Record.fromMap({
      '_body': '''
      <div class="mini-list-item">
    <a class="mini-list-item-title" href="/packages/redux"><h3>redux</h3></a>
    <div class="mini-list-item-body">
      <p class="mini-list-item-description">Redux is a predictable state container for Dart and Flutter apps</p>
    </div>
    <div class="mini-list-item-footer">
        <div class="mini-list-item-publisher">
          <img class="publisher-badge" src="/static/img/verified-publisher-gray.svg?hash=je610l58nj7vkvrdmrhakp3npkle6iol" title="Published by a pub.dev verified publisher">
          <a class="publisher-link" href="/publishers/fluttercommunity.dev">fluttercommunity.dev</a>
        </div>
    </div>
  </div>'''
    });

    var records = stage.process(record);

    expect(records, isNotEmpty);
    expect(records[0], isNotNull);

    print(jsonEncode(records[0]));
  });
}
