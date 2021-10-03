import 'package:riverflow/riverflow.dart';
import 'package:riverflow/src/extractors/collector.dart';
import 'package:riverflow/src/extractors/string_extractor.dart';
import 'package:test/test.dart';

void main() {
  group('String Extractor tests', () {
    test('Trim should OK', () {
      var html = '        This is a string      ';
      var extractor = StringTrimExtractor();

      var result = extractor.extract(html);

      expect(result, isNotNull);
      expect(result, isNotEmpty);
      expect(result[0] == 'This is a string', isTrue);
    });

    test('Remove empty should OK', () {
      var extractor = StringRemoveEmptyExtractor();

      var result = extractor.extract('                 ');

      expect(result, isNotNull);
      expect(result, isEmpty);
    });

    test('Split string and get first should OK', () {
      var html = 'a1=v1,b2=v2,c=12';
      var extractor = StringSplitterExtractor(
        delimiter: ',',
        collectType: CollectTypes.FIRST,
      );

      var result = extractor.extract(html);

      expect(result, isNotNull);
      expect(result, isNotEmpty);
      expect(result[0] == 'a1=v1', isTrue);
    });

    test('Split and get last should OK', () {
      var html = 'a1=v1,b2=v2,c=12';
      var extractor = StringSplitterExtractor(
        delimiter: ',',
        collectType: CollectTypes.LAST,
      );

      var result = extractor.extract(html);

      expect(result, isNotNull);
      expect(result, isNotEmpty);
      expect(result[0] == 'c=12', isTrue);
    });


    test('Split and get array should OK', () {
      var html = 'a1=v1,b2=v2,c=12';
      var extractor = StringSplitterExtractor(
        delimiter: ',',
        collectType: CollectTypes.ARRAY,
      );

      var result = extractor.extract(html);

      expect(result, isNotNull);
      expect(result, isNotEmpty);
      expect(result, ['a1=v1', 'b2=v2', 'c=12']);
    });



  });
}
