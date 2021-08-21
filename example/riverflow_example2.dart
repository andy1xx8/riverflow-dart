import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverflow/riverflow.dart';

void main() async {
  final template = Template.fromJson(jsonDecode(r'''
    {
      "stages": [
        {
          "type": "dom",
          "input_mapping": {
            "package_html": "/_body"
          },
          "output_fields": {
            "package_html": {
              "type": "field_selector",
              "is_flatten": true,
              "extractors": [
                {
                  "type": "html_include",
                  "selector": "div[class=\"packages\"] div[class=\"packages-item\"]"
                }
              ],
              "collect_as": {
                "type": "array",
                "data_type": "html_element",
                "default_value": null
              }
            }
          },
          "exclude_mapping": [
            "/_body"
          ]
        },
        {
          "type": "dom",
          "input_mapping": {
            "package_name": "/package_html",
            "description": "/package_html",
            "likes": "/package_html",
            "health": "/package_html",
            "popularity": "/package_html"
          },
          "output_fields": {
            "package_name": {
              "type": "field_selector",
              "is_flatten": false,
              "extractors": [
                {
                  "type": "html",
                  "selector": "h3[class=\"packages-title\"]",
                  "collectors": [
                    "${text()}"
                  ]
                },
                {
                  "type": "string_trim"
                }
              ],
              "collect_as": {
                "type": "first",
                "data_type": "string",
                "default_value": null
              }
            },
            "description": {
              "type": "field_selector",
              "is_flatten": false,
              "extractors": [
                {
                  "type": "html",
                  "selector": "p[class=\"packages-description\"]",
                  "collectors": [
                    "${text()}"
                  ]
                }
              ],
              "collect_as": {
                "type": "first",
                "data_type": "string",
                "default_value": null
              }
            },
            "likes": {
              "type": "field_selector",
              "is_flatten": false,
              "extractors": [
                {
                  "type": "html",
                  "selector": "div[class*=\"packages-score-like\"] *[class=\"packages-score-value-number\"]",
                  "collectors": [
                    "${text()}"
                  ]
                }
              ],
              "collect_as": {
                "type": "first",
                "data_type": "int",
                "default_value": 0
              }
            },
            "health": {
              "type": "field_selector",
              "is_flatten": false,
              "extractors": [
                {
                  "type": "html",
                  "selector": "div[class*=\"packages-score-health\"] *[class=\"packages-score-value-number\"]",
                  "collectors": [
                    "${text()}"
                  ]
                }
              ],
              "collect_as": {
                "type": "first",
                "data_type": "int",
                "default_value": 0
              }
            },
            "popularity": {
              "type": "field_selector",
              "is_flatten": false,
              "extractors": [
                {
                  "type": "html",
                  "selector": "div[class*=\"packages-score-popularity\"] *[class=\"packages-score-value-number\"]",
                  "collectors": [
                    "${text()}"
                  ]
                }
              ],
              "collect_as": {
                "type": "first",
                "data_type": "string",
                "default_value": null
              }
            }
          },
          "exclude_mapping": [
            "/package_html"
          ]
        }
      ]
    }
  '''));

  final flow = WebFlow(template);

  final response = await http.get('https://pub.dev/flutter/favorites');
  final html = response.body;

  var records = flow.start([html.asDocument('https://pub.dev').documentElement]);

  records.forEach((record) {
    print(jsonEncode(record.toJson()));
    print('--------------------------\n');
  });
}
