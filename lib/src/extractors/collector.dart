import 'package:riverflow/src/selector/output_converter.dart';

class CollectTypes {
  CollectTypes._();

  static const String FIRST = 'first';
  static const String LAST = 'last';
  static const String SINGLE = 'single';
  static const String ARRAY = 'array';
  static const String DISTINCT_ARRAY = 'distinct_array';
  static const String ARRAY_SIZE = 'array_size';
}

abstract class Collector<T> {
  final String type;
  final String dataType;
  final dynamic defaultValue;

  const Collector(this.type, this.dataType, this.defaultValue);

  T collectOutput(dynamic input);

  dynamic _collectFromInput(input) {
    switch (type) {
      case CollectTypes.FIRST:
        return _collectFirst(input);
      case CollectTypes.LAST:
        return _collectLast(input);
      case CollectTypes.SINGLE:
        return _collectAsSingle(input);
      case CollectTypes.ARRAY:
        return _collectList(input);
      case CollectTypes.DISTINCT_ARRAY:
        return _collectDistinctList(input);
      case CollectTypes.ARRAY_SIZE:
        return _collectItemCount(input);
      default:
        return _collectDefault(input);
    }
  }

  dynamic _collectFirst(input) {
    if ((input is List)) {
      return input?.firstWhere((element) => true, orElse: () => null);
    } else {
      return input;
    }
  }

  dynamic _collectLast(input) {
    if ((input is List)) {
      return input?.lastWhere((element) => true, orElse: () => null);
    } else {
      return input;
    }
  }

  dynamic _collectAsSingle(input) {
    if (input is List) {
      return input?.join('\n');
    } else {
      return input;
    }
  }

  int _collectItemCount(input) {
    if (input is List) {
      return input?.length ?? 0;
    } else {
      return input != null ? 1 : 0;
    }
  }

  List _collectDistinctList(input) {
    final fields = _collectList(input);
    final distinctList = <dynamic>[];
    final track = <dynamic>{};
    fields.forEach((element) {
      if (!track.contains(element)) {
        distinctList.add(element);
        track.add(element);
      }
    });
    track.clear();

    return distinctList;
  }

  List _collectList(input) {
    if (input is List) {
      return input;
    } else {
      return [input].where((element) => element != null).toList();
    }
  }

  dynamic _collectDefault(input) {
    final index = _parseItemIndex(type);
    if (index != null) {
      return _collectItemAt(input, index);
    } else {
      return input;
    }
  }

  int _parseItemIndex(String type) {
    final regExp = RegExp('(?<index>-?\\d+)');
    if (regExp.hasMatch(type)) {
      return int.parse(regExp.firstMatch(type).namedGroup('index'));
    } else {
      return null; // No index pattern was found in the source ( collectAs)
    }
  }

  dynamic _collectItemAt(dynamic input, int index) {
    final fields = _collectList(input);

    if (index >= 0 && index < fields.length) {
      final ele = index >= 0 ? fields[index] : fields[fields.length + index];
      return ele;
    } else {
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['type'] = type;
    json['data_type'] = dataType;
    json['default_value'] = defaultValue;
    return json;
  }
}

class DefaultCollector extends Collector<dynamic> {
  const DefaultCollector(String collectAs, String outputType, dynamic defaultValue)
      : super(collectAs, outputType, defaultValue);

  @override
  dynamic collectOutput(dynamic input) {
    final output = _collectFromInput(input);
    return OutputConverter(dataType, defaultValue).convert(output);
  }

  factory DefaultCollector.fromJson(Map<String, dynamic> json) {
    return DefaultCollector(json['type'], json['data_type'], json['default_value']);
  }
}

class ExtractorCollector extends Collector<List> {
  const ExtractorCollector(String collectAs, String outputType, dynamic defaultValue)
      : super(collectAs, outputType, defaultValue);

  @override
  List collectOutput(input) {
    final output = OutputConverter(dataType, defaultValue).convert(_collectFromInput(input));
    if (output is List) {
      return output;
    } else {
      return [output].toList();
    }
  }

  factory ExtractorCollector.fromJson(Map<String, dynamic> json) {
    return ExtractorCollector(
      json['type'],
      json['data_type'],
      json['default_value'],
    );
  }
}
