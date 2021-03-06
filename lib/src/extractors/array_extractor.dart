import 'package:riverflow/src/extractors/extractor.dart';
import 'package:riverflow/src/extractors/extractor_types.dart';

/// An extractor to get an element from a array
class ArrayGetExtractor extends Extractor {
  final int index;

  ArrayGetExtractor({
    this.index = 1,
  }) : super(ExtractorTypes.ARRAY_GET);

  @override
  List extract(input) {
    final srcInputs = _prepareInputSource(input);
    var idx = 0;
    if (index < 0) {
      idx = srcInputs.length + index;
    } else {
      idx = index;
    }
    if (idx >= 0 && idx < srcInputs.length) {
      return [srcInputs[idx]];
    } else {
      return [];
    }
  }

  List _prepareInputSource(dynamic input) {
    if (input is List) {
      return input;
    } else {
      return [input].where((element) => element != null).map((e) => e!).toList();
    }
  }

  factory ArrayGetExtractor.fromJson(Map<String, dynamic> json) {
    return ArrayGetExtractor(index: json['index'] ?? 0);
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['index'] = index;
    return json;
  }
}

class ArrayRemoveFirstExtractor extends Extractor {
  final int count;

  ArrayRemoveFirstExtractor({
    required this.count,
  }) : super(ExtractorTypes.ARRAY_REMOVE_FIRST);

  @override
  List extract(input) {
    final srcInputs = _prepareInputSource(input);
    if (count >= 1 && count <= srcInputs.length) {
      return srcInputs.skip(count).toList();
    } else {
      return srcInputs;
    }
  }

  List _prepareInputSource(dynamic input) {
    if (input is List) {
      return input;
    } else {
      return [input].where((e) => e != null).map((e) => e!).toList();
    }
  }

  factory ArrayRemoveFirstExtractor.fromJson(Map<String, dynamic> json) {
    return ArrayRemoveFirstExtractor(count: json['count'] ?? 1);
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['count'] = count;
    return json;
  }
}
