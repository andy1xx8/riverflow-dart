import 'package:riverflow/src/extractors/switchcase_extractor.dart';
import 'package:test/test.dart';

void main() {
  group('Switch Case Extractor tests', () {
    test('Switch should OK', () {
      var inputDateTime = 'hello';
      var extractor = SwitchCaseExtractor(options: {
        'hello': 'Xin chào',
      });

      var result = extractor.extract(inputDateTime);

      expect(result, isNotNull);
      expect(result, isNotEmpty);
      expect(result[0], 'Xin chào');
      result.forEach((element) {
        print('$element');
      });
    });
  });
}
