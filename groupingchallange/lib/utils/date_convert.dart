import 'package:groupingchallange/constants/enum.dart';
import 'package:intl/intl.dart';

class DateConvert {
  static String convertTsToDate(String tsString, TsConvertTo convertTo) {
    final datetime = convertTsToDateTime(tsString);
    if (convertTo == TsConvertTo.DATE) {
      return DateFormat.yMMMd().format(datetime);
    } else {
      return DateFormat.Hm().format(datetime);
    }
  }

  static DateTime convertTsToDateTime(String tsString) {
    final ts = int.parse(tsString);
    return DateTime.fromMillisecondsSinceEpoch(
      ts * 1000,
    );
  }
}
