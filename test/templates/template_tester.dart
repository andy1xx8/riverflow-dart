import 'dart:convert';

import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:resource_portable/resource.dart';
import 'package:riverflow/riverflow.dart';
import 'package:test/test.dart';

class TemplateTester {
  Document? dom;
  Template? template;

  final String templateFile;
  final String url;

  TemplateTester(this.templateFile, this.url);

  Future<List<Record>> test() async {
    await fetch();
    final flow = WebFlow(template!);
    return flow.start([dom!.documentElement!]);
  }

  Future<List<Record>> testHtml(String html, String baseUrl) async {
    await _loadTemplate();
    final flow = WebFlow(template!);
    return flow.start([html.asDocument(baseUrl).documentElement!]);
  }

  Future<List<Record>> testDocument(Document doc) async {
    await _loadTemplate();
    final flow = WebFlow(template!);
    return flow.start([doc.documentElement!]);
  }

  Future _loadTemplate() async {
    if (template == null) {
      final json = await Resource(templateFile)
          .readAsString(encoding: Encoding.getByName('utf-8'));

      template = Template.fromJson(jsonDecode(json));
    }
    return true;
  }

  Future fetch() async {
    final response = await http.get(Uri.parse(url));
    expect(response, isNotNull);
    expect(response.body, isNotEmpty);
    dom = response.body.asDocument('https://voz.vn');

    return true;
  }
}
