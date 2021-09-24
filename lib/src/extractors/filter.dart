import 'dart:convert';

import 'package:html/dom.dart' as dom;

class FilterTypes {
  static const AND = 'and';
  static const OR = 'or';
  static const NOT = 'not';
  static const EQUAL = 'equal';
  static const NOT_EQUAL = 'not_equal';
  static const IN = 'in';
  static const NOT_IN = 'not_in';
}

abstract class Filter {
  final String type;

  Filter(this.type);

  bool isMatch(dynamic input);

  factory Filter.fromJson(Map<String, dynamic> json) {
    final type = json['type'];
    if (type == null) {
      throw FormatException('This is not a valid json for an Filter: ${jsonEncode(json)}');
    }
    switch (type) {
      case FilterTypes.AND:
        return AndLogicalFilter.fromJson(json);
      case FilterTypes.OR:
        return OrLogicalFilter.fromJson(json);
      case FilterTypes.NOT:
        return NotLogicalFilter.fromJson(json);
      case FilterTypes.EQUAL:
        return EqualFilter.fromJson(json);
      case FilterTypes.NOT_EQUAL:
        return NotEqualFilter.fromJson(json);
      case FilterTypes.IN:
        return InFilter.fromJson(json);
      case FilterTypes.NOT_IN:
        return NotInFilter.fromJson(json);
      default:
        throw UnsupportedError('Unknown extractor type: $type');
    }
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['type'] = type;
    return json;
  }
}

class AndLogicalFilter extends Filter {
  final List<Filter> filters;

  AndLogicalFilter(this.filters) : super(FilterTypes.AND);

  @override
  bool isMatch(input) {
    if (filters.isNotEmpty) {
      final results = filters.map((filter) => filter.isMatch(input)).toList();
      return results.where((element) => element == false).isEmpty;
    } else {
      return true;
    }
  }

  factory AndLogicalFilter.fromJson(Map<String, dynamic> json) {
    return AndLogicalFilter(
      json['filters'].map<Filter>((json) => Filter.fromJson(json)).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['filters'] = filters.map((e) => e.toJson()).toList();
    return json;
  }
}

class OrLogicalFilter extends Filter {
  final List<Filter> filters;

  OrLogicalFilter(this.filters) : super(FilterTypes.OR);

  @override
  bool isMatch(input) {
    if (filters.isNotEmpty) {
      final results = filters.map((filter) => filter.isMatch(input)).toList();
      return results.where((element) => element == true).isNotEmpty;
    } else {
      return true;
    }
  }

  factory OrLogicalFilter.fromJson(Map<String, dynamic> json) {
    return OrLogicalFilter(
      json['filters'].map<Filter>((json) => Filter.fromJson(json)).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['filters'] = filters.map((e) => e.toJson()).toList();
    return json;
  }
}

class NotLogicalFilter extends Filter {
  final Filter filter;

  NotLogicalFilter(this.filter) : super(FilterTypes.NOT);

  @override
  bool isMatch(input) {
    return !filter.isMatch(input);
  }

  factory NotLogicalFilter.fromJson(Map<String, dynamic> json) {
    return NotLogicalFilter(
      Filter.fromJson(json['filter']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['filter'] = filter.toJson();
    return json;
  }
}

class EqualFilter extends Filter {
  final List<String> values;

  EqualFilter(this.values) : super(FilterTypes.EQUAL);

  @override
  bool isMatch(input) {
    final target = values[0];
    return target == _parseInputAsStr(input);
  }

  static String? _parseInputAsStr(dynamic input) {
    if (input is dom.Document) {
      return input.documentElement!.outerHtml;
    } else if (input is dom.Element) {
      return input.outerHtml;
    } else if (input is String) {
      return input;
    } else {
      return input?.toString();
    }
  }

  factory EqualFilter.fromJson(Map<String, dynamic> json) {
    return EqualFilter(
      json['values'].map<String>((v) => v as String).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['values'] = values;
    return json;
  }
}

class NotEqualFilter extends Filter {
  final List<String> values;

  NotEqualFilter(this.values) : super(FilterTypes.NOT_EQUAL);

  @override
  bool isMatch(input) {
    final target = values[0];
    return !(target == _parseInputAsStr(input));
  }

  static String? _parseInputAsStr(dynamic input) {
    if (input is dom.Document) {
      return input.documentElement!.outerHtml;
    } else if (input is dom.Element) {
      return input.outerHtml;
    } else if (input is String) {
      return input;
    } else {
      return input?.toString();
    }
  }

  factory NotEqualFilter.fromJson(Map<String, dynamic> json) {
    return NotEqualFilter(
      json['values'].map<String>((v) => v as String).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['values'] = values;
    return json;
  }
}

class InFilter extends Filter {
  final List<String> values;

  InFilter(this.values) : super(FilterTypes.IN);

  @override
  bool isMatch(input) {
    final src = _parseInputAsStr(input);
    return values.map((target) => target == src).where((element) => element == true).isNotEmpty;
  }

  static String? _parseInputAsStr(dynamic input) {
    if (input is dom.Document) {
      return input.documentElement!.outerHtml;
    } else if (input is dom.Element) {
      return input.outerHtml;
    } else if (input is String) {
      return input;
    } else {
      return input?.toString();
    }
  }

  factory InFilter.fromJson(Map<String, dynamic> json) {
    return InFilter(
      json['values'].map<String>((v) => v as String).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['values'] = values;
    return json;
  }
}

class NotInFilter extends Filter {
  final List<String> values;

  NotInFilter(this.values) : super(FilterTypes.NOT_IN);

  @override
  bool isMatch(input) {
    final src = _parseInputAsStr(input);
    return values.map((target) => target == src).where((element) => element == true).isEmpty;
  }

  static String? _parseInputAsStr(dynamic input) {
    if (input is dom.Document) {
      return input.documentElement!.outerHtml;
    } else if (input is dom.Element) {
      return input.outerHtml;
    } else if (input is String) {
      return input;
    } else {
      return input?.toString();
    }
  }

  factory NotInFilter.fromJson(Map<String, dynamic> json) {
    return NotInFilter(
      json['values'].map<String>((v) => v as String).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['values'] = values;
    return json;
  }
}
