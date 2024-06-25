import 'package:html/dom.dart' as dom;
import 'package:riverflow/riverflow.dart';

abstract class Flow {
  final List<Stage> stages;

  Flow(this.stages);

  List<Record> start(List<dom.Element> elementList);

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    return json;
  }
}

class WebFlow extends Flow {
  WebFlow(Template template) : super(template.stages);

  @override
  List<Record> start(List<dom.Element> elementList) {
    return elementList
        .map((element) => Record.fromMap({'_body': element}))
        .expand((record) => _floatViaStages(record))
        .toList();
  }

  /// Flow an input record throw each and every barrages.
  /// Return [List<Record>] - list of records at the end the flow.
  List<Record> _floatViaStages(Record record) {
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
