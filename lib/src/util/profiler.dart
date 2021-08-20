import 'package:dolumns/dolumns.dart';


class MeasureValue {
  static final List<String> HEADERS = [
    "No",
    "Name",
    "Total Req",
    "Pending Req",
    "Total Exec Time",
    "Last Exec Time",
    "Highest Exec Time",
    "Request Rate (req/sec)",
    "Avg Time/Request (millis/request)",
  ];

  final String funcName;
  int totalHits;
  int totalPendingHits;
  int totalDurationNs;
  int lastDurationNs;
  int lowestDurationNs;
  int highestDurationNs;

  MeasureValue(
    this.funcName, {
    this.totalHits = 0,
    this.totalPendingHits = 0,
    this.totalDurationNs = 0,
    this.lastDurationNs = -1,
    this.lowestDurationNs = -1,
    this.highestDurationNs = -1,
  });

  void start() {
    this.totalPendingHits += 1;
  }

  void stop(int durationInNs) {
    this.totalPendingHits -= 1;
    this.totalHits += 1;
    this.totalDurationNs += durationInNs;
    this.lastDurationNs = durationInNs;

    if (this.lowestDurationNs == -1 || this.lowestDurationNs > durationInNs) {
      this.lowestDurationNs = durationInNs;
    }

    if (this.highestDurationNs == -1 || this.highestDurationNs < durationInNs) {
      this.highestDurationNs = durationInNs;
    }
  }

  String getTotalDurationAsMs() {
    return (this.totalDurationNs ~/ 1000000).toString();
  }

  String getLastDurationAsMs() {
    return (this.lastDurationNs / 1000000).toStringAsFixed(4);
  }

  String getLowestDurationAsMs() {
    return (this.lowestDurationNs / 1000000).toStringAsFixed(4);
  }

  String getHighestDurationAsMs() {
    return (this.highestDurationNs / 1000000).toStringAsFixed(4);
  }

  String getRequestRate() {
    final durationAsMs = this.totalDurationNs ~/ 1000000;

    if (durationAsMs > 0) {
      return ((this.totalHits * 1000) / durationAsMs).toStringAsFixed(4);
    } else {
      return '';
    }
  }

  String getAvgTimePerRequest() {
    if (this.totalHits > 0) {
      final durationAsMs = this.totalDurationNs / 1000000;
      return (durationAsMs / totalHits).toStringAsFixed(4);
    } else {
      return '';
    }
  }
}

class ProfilerService {
  final Map<String, MeasureValue> _measureMap = new Map();

  MeasureValue getMeasureValue(String funcName) {
    var measureValue = this._measureMap[funcName];
    if (measureValue == null) {
      measureValue = MeasureValue(funcName);
      this._measureMap[funcName] = measureValue;
    }

    return measureValue;
  }

  void start(String funcName) {
    getMeasureValue(funcName).start();
  }

  void stop(String funcName, int durationNs) {
    getMeasureValue(funcName).stop(durationNs);
  }

  List<MeasureValue> getReports() {
    final records = this._measureMap.values.toList();
    records.sort((a, b) {
      return a.funcName.compareTo(b.funcName);
    });

    return records;
  }

  String asTable() {
    final reports = getReports();

    var idx = 0;
    var columns = [
      MeasureValue.HEADERS,
    ];

    reports.forEach((element) {
      columns.add([
        (idx + 1).toString(),
        element.funcName,
        element.totalHits.toString(),
        element.totalPendingHits.toString(),
        element.getTotalDurationAsMs(),
        element.getLastDurationAsMs(),
        element.getLowestDurationAsMs(),
        element.getRequestRate(),
        element.getAvgTimePerRequest()
      ]);
      idx += 1;
    });

    return dolumnify(
      columns,
      columnSplitter: ' | ',
      headerIncluded: true,
      headerSeparator: '=',
    );
  }
}
