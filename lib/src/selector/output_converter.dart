import 'package:riverflow/src/selector/field_selector.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

class DataConverter {
  final String outputType;
  final dynamic defaultValue;

  DataConverter(this.outputType, this.defaultValue);

  dynamic convert(dynamic input) {
    var output;
    if (input is List) {
      output = _convertInputToList(input);
    } else {
      output = _convertInput(input);
    }
    return output ?? defaultValue;
  }

  List _convertInputToList(List<dynamic> inputs) {
    return inputs.map((e) => convert(e)).where((element) => element != null).toList();
  }

  dynamic _convertInput(dynamic input) {
    switch (outputType) {
      case OutputTypes.BOOL:
        return _convertToBool(input);
      case OutputTypes.SHORT:
        return _convertToInt(input);
      case OutputTypes.BYTE:
        return _convertToInt(input);
      case OutputTypes.INT:
        return _convertToInt(input);
      case OutputTypes.LONG:
        return _convertToInt(input);
      case OutputTypes.FLOAT:
        return _convertToDouble(input);
      case OutputTypes.DOUBLE:
        return _convertToDouble(input);
      case OutputTypes.STRING:
        return _convertToString(input);
      case OutputTypes.DATE:
        return _convertToDate(input);
      case OutputTypes.HTML_ELEMENT:
        return _convertToHtmlElement(input);
      default:
        return input;
    }
  }

  bool? _convertToBool(dynamic input) {
    if (input == null) {
      return null;
    } else if (input is bool) {
      return input;
    } else if (input is int) {
      return input > 0;
    } else if (input is String) {
      return input.toLowerCase() == 'true';
    } else {
      throw FormatException('$input is not a valid bool value');
    }
  }

  int? _convertToInt(input) {
    if (input == null) {
      return null;
    } else if (input is bool) {
      return input ? 1 : 0;
    } else if (input is int) {
      return input;
    } else if (input is double) {
      return input.toInt();
    } else if (input is String) {
      return int.parse(input);
    } else if (input is DateTime) {
      return input.millisecondsSinceEpoch;
    } else {
      throw FormatException('$input is not a valid integer value');
    }
  }

  double? _convertToDouble(dynamic input) {
    if (input == null) {
      return null;
    } else if (input is bool) {
      return input ? 1 : 0;
    } else if (input is int) {
      return input.toDouble();
    } else if (input is double) {
      return input;
    } else if (input is String) {
      return double.parse(input);
    } else if (input is DateTime) {
      return input.millisecondsSinceEpoch.toDouble();
    } else {
      throw FormatException('$input is not a valid double value');
    }
  }

  String? _convertToString(dynamic input) {
    if (input == null) {
      return null;
    } else if (input is bool) {
      return input.toString();
    } else if (input is int) {
      return input.toString();
    } else if (input is double) {
      return input.toString();
    } else if (input is String) {
      return input;
    } else if (input is dom.Element) {
      return input.outerHtml.trim();
    } else {
      return input?.toString();
    }
  }

  DateTime? _convertToDate(dynamic input) {
    if (input == null) {
      return null;
    } else if (input is int) {
      return DateTime.fromMillisecondsSinceEpoch(input);
    } else if (input is DateTime) {
      return input;
    } else {
      throw FormatException('$input is not a valid double value');
    }
  }

  dom.Element? _convertToHtmlElement(dynamic input) {
    if (input == null) {
      return null;
    } else if (input is String) {
      return parser.parse(input).documentElement;
    } else if (input is dom.Element) {
      return input;
    } else {
      throw FormatException('$input is not a valid HTML DOM value');
    }
  }
}
