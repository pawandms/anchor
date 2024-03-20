
import 'package:intl/intl.dart';

class Helper{

  static  DateFormat _formatter = DateFormat('yyyy-MM-dd');

  static String getText(DateTime date) {
    final now = new DateTime.now();
    if (_formatter.format(now) == _formatter.format(date)) {
      return 'Today';
    } else if (_formatter
        .format(new DateTime(now.year, now.month, now.day - 1)) ==
        _formatter.format(date))   {
      return 'Yesterday';
    } else {
      return '${DateFormat('d').format(date)} ${DateFormat('MMMM').format(date)} ${DateFormat('y').format(date)}';
    }
  }
}