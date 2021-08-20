import 'package:html/dom.dart' as dom;
import 'package:riverflow/riverflow.dart';
import 'package:riverflow/src/domain/record.dart';
import 'package:riverflow/src/stage.dart';

abstract class Flow {
  factory Flow(List<Stage> stages) => WebFlow(stages);

  factory Flow.fromTemplate(Template template) => WebFlow(template.stages);

  List<Record> startFloating(List<dom.Element> elements);
}

class WebFlow implements Flow {
  final List<Stage> barrages;

  WebFlow(this.barrages);

  @override
  List<Record> startFloating(List<dom.Element> elementList) {
    return elementList
        .map((element) => Record.fromMap({'_body': element}))
        .expand((record) => _floatViaBarrages(record))
        .toList();
  }

  /// Flow an input record throw each and every barrages.
  /// Return [List<Record>] - list of records at the end the flow.
  List<Record> _floatViaBarrages(Record record) {
    return barrages.fold([record], (records, barrage) {
      return records.expand((element) => barrage.process(element)).toList();
    });
  }
}
