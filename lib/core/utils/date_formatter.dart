import 'package:intl/intl.dart';

class DateFormatter {
  static final _dateFormat = DateFormat('yyyy/MM/dd', 'ja_JP');
  static final _dateTimeFormat = DateFormat('yyyy/MM/dd HH:mm', 'ja_JP');

  static String formatDate(DateTime date) {
    return _dateFormat.format(date);
  }

  static String formatDateTime(DateTime date) {
    return _dateTimeFormat.format(date);
  }

  static String formatDueDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now);

    if (difference.inDays < 0) {
      return '期限切れ (${formatDate(date)})';
    } else if (difference.inDays == 0) {
      return '今日まで';
    } else if (difference.inDays == 1) {
      return '明日まで';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}日後まで';
    } else {
      return formatDate(date);
    }
  }
}
