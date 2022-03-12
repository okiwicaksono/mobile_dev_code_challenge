import 'package:intl/intl.dart';

class TimeConverter{
  static String dateWithMonthName(String timestamp){
    return DateFormat.yMMMd().format(DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp.padRight(13, '0'))));
  }
}