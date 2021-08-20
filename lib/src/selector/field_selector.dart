
import 'dart:convert';

import 'package:riverflow/src/extractors/collector.dart';
import 'package:riverflow/src/extractors/extractor.dart';

class SelectorTypes {
  SelectorTypes._();

  static const FieldSelector = 'field_selector';
}

class OutputTypes {
  OutputTypes._();

  static const String HTML_ELEMENT = 'html_element';
  static const String BOOL = 'bool';
  static const String BYTE = 'byte';
  static const String SHORT = 'short';
  static const String INT = 'int';
  static const String LONG = 'long';
  static const String FLOAT = 'float';
  static const String DOUBLE = 'double';
  static const String STRING = 'string';
  static const String DATE = 'date';
}



abstract class Selector {
  final String type;
  final bool isFlatten;

  Selector(this.type, this.isFlatten);

  dynamic select(dynamic input, {dynamic defaultValues});

  Map<String,dynamic> toJson() {
    var json = <String, dynamic>{};
    json['type'] = type;
    json['is_flatten'] = isFlatten??false;
    return json;
  }


  factory Selector.fromJson(Map<String, dynamic> json) {
    var type = json['type'];
    if(type == null) {
      throw FormatException('This is not a valid json for an selector: ${jsonEncode(json)}');
    }
    switch(type) {
      case SelectorTypes.FieldSelector: return FieldSelector.fromJson(json);
      default:
        throw UnsupportedError('Unknown selector type: $type');
    }
  }

}

class FieldSelector extends Selector {
  final List<Extractor> extractors;
  final Collector collectAs;

  FieldSelector({
    this.extractors,
    this.collectAs = const DefaultCollector(CollectTypes.FIRST, OutputTypes.STRING, null),
    bool isFlatten = false,
  }): super(SelectorTypes.FieldSelector,isFlatten??false);


  @override
  dynamic select(dynamic input, {dynamic defaultValues}) {
    try{
      var fields = _extract(input);
      return collectAs.collectOutput(fields);
    }catch(ex) {
      if(defaultValues==null) {
        rethrow;
      }
      return defaultValues;
    }
  }

  List _extract(input) {
    return extractors.fold([input], (List inputs, extractor){
      if(inputs.isNotEmpty) {
        return inputs.expand((input) => extractor.extract(input))
            .where((element) => element!=null)
            .toList();
      }
      return inputs;
    });
  }


  factory FieldSelector.fromJson(Map<String, dynamic> json) {
    return FieldSelector(
      extractors: json['extractors'].map<Extractor>((extractorJson) => Extractor.fromJson(extractorJson)).toList(),
      collectAs: json['collect_as']!=null? DefaultCollector.fromJson(json['collect_as']): DefaultCollector(
        CollectTypes.FIRST,
        OutputTypes.STRING,
        null,
      ),
      isFlatten: json['is_flatten']??false,
    );
  }

  @override
  Map<String,dynamic> toJson() {
    var json = super.toJson();
    json['extractors'] = extractors.map((e) => e.toJson()).toList();
    json['collect_as'] = collectAs.toJson();
    return json;
  }

}

