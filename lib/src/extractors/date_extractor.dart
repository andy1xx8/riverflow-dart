import 'package:riverflow/src/extractors/extractor.dart';
import 'package:riverflow/src/extractors/extractor_types.dart';
import 'package:html/dom.dart' as dom;
import 'package:intl/intl.dart';

class DateTimeUtils {
  DateTimeUtils._();

  static String prepareInputSource(dynamic input) {
    if (input is dom.Element) {
      return input.outerHtml.trim();
    } else if (input is String) {
      return input.trim();
    } else {
      return input.toString().trim();
    }
  }

  static DateTime parseInput(dynamic input, List<String> inputFormats) {
    final inputSource = prepareInputSource(input);
    return inputFormats.fold<DateTime>(null, (inputValue, format) {
      try {
        if (inputValue == null) {
          return DateFormat(format).parse(inputSource);
        } else {
          return inputValue;
        }
      } catch (ex) {
        return inputValue;
      }
    });
  }
}

class DateTimeExtractor extends Extractor {
  final List<String> inputFormats;
  final String outputFormat;

  DateTimeExtractor({
    this.inputFormats,
    this.outputFormat,
  }) : super(ExtractorTypes.DATETIME_CONVERTER);

  @override
  List extract(input) {
    final dateTime = DateTimeUtils.parseInput(input, inputFormats);
    if (dateTime != null) {
      return [DateFormat(outputFormat).format(dateTime)];
    } else {
      return [];
    }
  }

  factory DateTimeExtractor.fromJson(Map<String, dynamic> json) {
    return DateTimeExtractor(
      inputFormats: json['input_formats'].map<String>((e) => e as String).toList(),
      outputFormat: json['output_format'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['input_formats'] = inputFormats;
    json['output_format'] = outputFormat;
    return json;
  }
}

class EpochTimeExtractor extends Extractor {
  final List<String> inputFormats;

  EpochTimeExtractor({
    this.inputFormats,
  }) : super(ExtractorTypes.EPOCH_TIME_CONVERTER);

  @override
  List extract(input) {
    final dateTime = DateTimeUtils.parseInput(input, inputFormats);
    return [dateTime?.millisecondsSinceEpoch].where((element) => element != null).toList();
  }

  factory EpochTimeExtractor.fromJson(Map<String, dynamic> json) {
    return EpochTimeExtractor(
      inputFormats: json['input_formats'].map<String>((e) => e as String).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['input_formats'] = inputFormats;
    return json;
  }
}
