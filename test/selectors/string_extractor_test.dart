import 'package:riverflow/src/extractors/collector.dart';
import 'package:riverflow/src/extractors/string_extractor.dart';
import 'package:riverflow/src/selector/field_selector.dart';
import 'package:test/test.dart';

void main() {
  group('Selector tests', () {
    test('Split string to  list of int should OK', () {
      final selector = FieldSelector(
        extractors: [
          StringTrimExtractor(),
          StringSplitterExtractor(
            delimiter: ',',
            collectType: CollectTypes.DISTINCT_ARRAY,
          )
        ],
        collectAs: SingleFieldCollector(CollectTypes.DISTINCT_ARRAY, OutputTypes.INT, null),
      );

      final input = '        14,6,18,99,56,30,45,20     ';

      final result = selector.select(input);

      expect(result, isNotNull);
      expect(result, isNotEmpty);
      expect(result, [14, 6, 18, 99, 56, 30, 45, 20]);

      print(result);

    });
  });
}
