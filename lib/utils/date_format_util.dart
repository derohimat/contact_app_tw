import 'package:intl/intl.dart';

class DateFormatUtil {
  static final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  static String format(DateTime date) {
    return _dateFormat.format(date);
  }

  static DateTime? parse(String dateString) {
    try {
      return _dateFormat.parse(dateString);
    } catch (e) {
      return null;
    }
  }
}
