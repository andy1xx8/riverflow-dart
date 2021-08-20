import 'package:html/dom.dart' as dom;
import 'package:riverflow/riverflow.dart';
import 'package:riverflow/src/domain/record.dart';
import 'package:riverflow/src/stage.dart';

abstract class Flow {
  List<Record> startFloating(List<dom.Element> elements);

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    return json;
  }
}

class WebFlow extends Flow {
  final List<Stage> stages;

  WebFlow(this.stages);

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
    return stages.fold([record], (records, barrage) {
      return records.expand((element) => barrage.process(element)).toList();
    });
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'stages': stages.map((e) => e.toJson()).toList(),
    };
  }
}
