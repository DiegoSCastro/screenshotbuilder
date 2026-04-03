import 'package:intl/intl.dart';

extension DateExt on DateTime {
  ///[hhMMa] will format DateTime to String in 'hh:mm:a'
  ///
  ///----------
  ///```
  /// //example
  ///final time=DateTime.now().hhMMa;
  ///print(time);//10:20 am
  ///```
  String get hhMMa => DateFormat('hh:mm a').format(this);

  ///[dMMMyOrTY] will convert DateTime to String in '12 May 2024' format
  ///or 'Today' or 'Yesterday' based on the date
  ///
  ///----------
  ///```
  /// //example
  ///final converted=DateTime.now().dMMMyOrTY;
  ///print(converted);//Today
  ///```
  String get dMMMyOrTY {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final compDt = DateTime(year, month, day);
    final difference = today.difference(compDt).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else {
      return DateFormat('d MMM, y').format(this);
    }
  }

  ///[yyyyMmDdWithDash] will convert DateTime to String in "2024-05-05" format
  ///
  ///----------
  ///```
  /// //example
  ///final dateString=DateTime.now().yyyyMmDdWithDash;
  ///print(dateString);//2024-08-05
  ///```
  String get yyyyMmDdWithDash => DateFormat('yyyy-MM-dd').format(this);

  ///[yyyMmDdWithSlash] will convert DateTime to String in "2024/05/05" format
  ///
  ///----------
  ///```
  /// //example
  ///final dateString=DateTime.now().yyyyMmDdWithSlash;
  ///print(dateString);//2024/08/05
  ///```
  String get yyyMmDdWithSlash => DateFormat('yyyy/MM/dd').format(this);

  ///[formatAsDdMMMyyy] will convert DateTime to String in "10 Apr, 2024" format
  ///
  ///----------
  ///```
  /// //example
  ///final dateString=DateTime.now().formatAsDdMMMyyy;
  ///print(dateString);// 10 Apr, 2024
  ///```
  String get formatAsDdMMMyyy => DateFormat('d MMM, yyyy').format(this);
}

