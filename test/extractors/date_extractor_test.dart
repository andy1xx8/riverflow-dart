import 'package:riverflow/src/extractors/date_extractor.dart';
import 'package:test/test.dart';

void main() {
  group('Date Extractor tests', () {

    test('Convert date should OK', () {

      var inputDateTime = '12-06-2012 07:13';
      var extractor = DateTimeExtractor(
        inputFormats: ['dd-MM-yyyy HH:mm'],
        outputFormat: 'dd/MM/yyyy HH:mm:ss'
      );

      var result = extractor.extract(inputDateTime);

      expect(result, isNotNull);
      expect(result, isNotEmpty);
      expect(result[0] == '12/06/2012 07:13:00', isTrue);
      result.forEach((element) {
        print('$element');
      });
    });

    test('Convert date to Epoch should OK', () {

      var inputDateTime = '12-06-2012 07:13';
      var extractor = EpochTimeExtractor(
          inputFormats: ['dd-MM-yyyy HH:mm'],
      );

      var result = extractor.extract(inputDateTime);

      expect(result, isNotNull);
      expect(result, isNotEmpty);
      expect(result[0], 1339459980000);
      result.forEach((element) {
        print('$element');
      });
    });

  });


}
