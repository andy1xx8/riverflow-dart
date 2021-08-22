A library for Dart developers.

## Usage

1. Create a Template 

```dart

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverflow/riverflow.dart';

final stage1 = DomStage(
  inputMapping: {
    'package_html': '/_body',
  },
  outputFields: {
    'package_html': FieldSelector(
      extractors: [
        HtmlIncludeExtractor(
          selector: 'div[class="packages"] div[class="packages-item"]',
        )
      ],
      isFlatten: true,
      collectAs: DefaultCollector(CollectTypes.ARRAY, OutputTypes.HTML_ELEMENT, null),
    ),
  },
  excludeMapping: {
    '/_body',
  },
);
final stage2 = DomStage(
  inputMapping: {
    'package_name': '/package_html',
    'description': '/package_html',
    'likes': '/package_html',
    'health': '/package_html',
    'popularity': '/package_html',
  },
  outputFields: {
    'package_name': FieldSelector(
      extractors: [
        HtmlExtractor(selector: 'h3[class="packages-title"]', collectors: [r'${text()}']),
        StringTrimExtractor(),
      ],
    ),
    'description': FieldSelector(
      extractors: [
        HtmlExtractor(selector: 'p[class="packages-description"]', collectors: [r'${text()}'])
      ],
    ),
    'likes': FieldSelector(
      extractors: [
        HtmlExtractor(
            selector: 'div[class*="packages-score-like"] *[class="packages-score-value-number"]',
            collectors: [r'${text()}'])
      ],
      collectAs: DefaultCollector(CollectTypes.FIRST, OutputTypes.INT, 0),
    ),
    'health': FieldSelector(
      extractors: [
        HtmlExtractor(
            selector: 'div[class*="packages-score-health"] *[class="packages-score-value-number"]',
            collectors: [r'${text()}']),
      ],
      collectAs: DefaultCollector(CollectTypes.FIRST, OutputTypes.INT, 0),
    ),
    'popularity': FieldSelector(
      extractors: [
        HtmlExtractor(
            selector: 'div[class*="packages-score-popularity"] *[class="packages-score-value-number"]',
            collectors: [r'${text()}']),
      ],
    ),
  },
  excludeMapping: {
    '/package_html',
  },
);

final template = Template([stage1, stage2]);
```

- Or Create a Template from a Json String

```dart
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
                  "type": "trim_string"
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
```

2. Create a WebFlow

```dart
final flow = WebFlow(template);
```

3. Download a web page and build a document

```dart
import 'dart:convert';

import 'package:http/http.dart' as http;

void main() async {

  final response = await http.get('https://pub.dev/flutter/favorites');
  final doc = response.body.asDocument('https://pub.dev');
}
```


4. Start a flow and get the output result

```dart
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverflow/riverflow.dart';

var records = flow.startFloating([doc.documentElement]);

records.forEach((record) {
print(jsonEncode(record.toJson()));
print('--------------------------\n');
});
```


The result should look like this
```json
[
  {
    "package_name": "shared_preferences",
    "description": "Flutter plugin for reading and writing simple key-value pairs. Wraps NSUserDefaults on iOS and SharedPreferences on Android.",
    "likes": 1233,
    "health": 110,
    "popularity": "100"
  },
  {
    "package_name": "url_launcher",
    "description": "Flutter plugin for launching a URL on Android and iOS. Supports web, phone, SMS, and email schemes.",
    "likes": 858,
    "health": 110,
    "popularity": "100"
  },
  {
    "package_name": "flutter_bloc",
    "description": "Flutter Widgets that make it easy to implement the BLoC (Business Logic Component) design pattern. Built to be used with the bloc state management package.",
    "likes": 821,
    "health": 110,
    "popularity": "99"
  },
  {
    "package_name": "bloc",
    "description": "A predictable state management library that helps implement the BLoC (Business Logic Component) design pattern.",
    "likes": 440,
    "health": 110,
    "popularity": "99"
  },
  {
    "package_name": "location",
    "description": "A Flutter plugin to easily handle realtime location in iOS and Android. Provides settings for optimizing performance or battery.",
    "likes": 333,
    "health": 110,
    "popularity": "99"
  },
  {
    "package_name": "flutter_slidable",
    "description": "A Flutter implementation of slidable list item with directional slide actions that can be dismissed.",
    "likes": 623,
    "health": 110,
    "popularity": "98"
  },
  {
    "package_name": "built_value",
    "description": "Value types with builders, Dart classes as enums, and serialization. This library is the runtime dependency.\n",
    "likes": 127,
    "health": 110,
    "popularity": "99"
  },
  {
    "package_name": "convex_bottom_bar",
    "description": "A Flutter package which implements a ConvexAppBar to show a convex tab in the bottom bar. Theming supported.",
    "likes": 250,
    "health": 110,
    "popularity": "92"
  },
  {
    "package_name": "provider",
    "description": "A wrapper around InheritedWidget to make them easier to use and more reusable.",
    "likes": 1736,
    "health": 105,
    "popularity": "100"
  },
  {
    "package_name": "rxdart",
    "description": "RxDart is an implementation of the popular reactiveX api for asynchronous programming, leveraging the native Dart Streams api.\n",
    "likes": 535,
    "health": 105,
    "popularity": "100"
  }
]
```