import 'package:dolumns/dolumns.dart';

class MeasureValue {
  static final List<String> HEADERS = [
    'No',
    'Name',
    'Total Req',
    'Pending Req',
    'Total Exec Time',
    'Last Exec Time',
    'Highest Exec Time',
    'Request Rate (req/sec)',
    'Avg Time/Request (millis/request)',
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
    totalPendingHits += 1;
  }

  void stop(int durationInNs) {
    totalPendingHits -= 1;
    totalHits += 1;
    totalDurationNs += durationInNs;
    lastDurationNs = durationInNs;

    if (lowestDurationNs == -1 || lowestDurationNs > durationInNs) {
      lowestDurationNs = durationInNs;
    }

    if (highestDurationNs == -1 || highestDurationNs < durationInNs) {
      highestDurationNs = durationInNs;
    }
  }

  String getTotalDurationAsMs() {
    return (totalDurationNs ~/ 1000000).toString();
  }

  String getLastDurationAsMs() {
    return (lastDurationNs / 1000000).toStringAsFixed(4);
  }

  String getLowestDurationAsMs() {
    return (lowestDurationNs / 1000000).toStringAsFixed(4);
  }

  String getHighestDurationAsMs() {
    return (highestDurationNs / 1000000).toStringAsFixed(4);
  }

  String getRequestRate() {
    final durationAsMs = totalDurationNs ~/ 1000000;

    if (durationAsMs > 0) {
      return ((totalHits * 1000) / durationAsMs).toStringAsFixed(4);
    } else {
      return '';
    }
  }

  String getAvgTimePerRequest() {
    if (totalHits > 0) {
      final durationAsMs = totalDurationNs / 1000000;
      return (durationAsMs / totalHits).toStringAsFixed(4);
    } else {
      return '';
    }
  }
}

class ProfilerService {
  final Map<String, MeasureValue> _measureMap = {};

  MeasureValue getMeasureValue(String funcName) {
    var measureValue = _measureMap[funcName];
    if (measureValue == null) {
      measureValue = MeasureValue(funcName);
      _measureMap[funcName] = measureValue;
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
    final records = _measureMap.values.toList();
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
