import 'package:intl/intl.dart';

class ConvertMsToDatetime {
  static String convertMsToDatetime(String millisecond) {
    if (int.tryParse(millisecond) != null) {
      return DateFormat('HH:mm').format(
          DateTime.fromMillisecondsSinceEpoch(int.parse(millisecond) * 1000));
    } else {
      return DateFormat('HH:mm').format(DateTime.now());
    }
  }
}
