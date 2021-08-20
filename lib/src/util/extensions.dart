import 'package:html/dom.dart' as dom;
import 'package:riverflow/src/util/html_utils.dart';

extension HtmlStringExtension on String {
  dom.Document asDocument(String baseUrl) {
    return HtmlUtils.resolveDOM(this, baseUrl);
  }
}
