import 'package:intl/intl.dart';

extension FormatDateTimeExtension on DateTime {
  String formatDate([String? locale]) =>
      DateFormat('yyyy/MM/dd', locale).format(this);

  String formatTime([String? locale]) =>
      DateFormat('HH:mm', locale).format(this);

  String formatDOW([String? locale]) => DateFormat('EEEE', locale).format(this);

  String format([String? locale]) =>
      DateFormat('yyyy-MM-dd HH:mm', locale).format(this);
}
