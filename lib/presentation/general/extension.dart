import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String format({required String format}) {
    final dateTimeFormatted = DateFormat(format).format(this);
    return dateTimeFormatted;
  }
}
