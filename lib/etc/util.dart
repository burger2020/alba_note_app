import 'package:albanote_project/config/repository_config.dart';
import 'package:intl/intl.dart';

class Util {
  /// 14:00:00 -> 14:00
  static String convertTimeStampToHourNMinute(String? t, {bool short = false}) {
    if (short) {
      if (t == null) return "00:00";
      var times = t.split(":");
      return times.first + ":" + times[1];
    } else {
      if (t == null) return "00시 00분";
      var times = t.split(":");
      return times.first + "시 " + times[1] + '분';
    }
  }

  // dateTime -> yyyy. MM. dd EE
  static String convertDateToYYYYMMDDEE(String? t) {
    var dateFormat = DateFormat('yyyy. MM. dd EE');
    var date = dateFormat
        .format(DateTime.parse(t ?? DateTime.now().toString()))
        .replaceFirst('Mon', '월')
        .replaceFirst('Tue', '화')
        .replaceFirst('Wed', '수')
        .replaceFirst('Thu', '목')
        .replaceFirst('Fri', '금')
        .replaceFirst('Sat', '토')
        .replaceFirst('Sun', '일');

    return date;
  }

  // dateTime -> yyyy년 MM월 dd일
  static String convertDateToAgoTime(String? t) {
    if (t == null) return '';
    var current = RepositoryConfig.getCurrentTime();
    var diff = DateTime.parse(t).difference(current);
    var text = '';

    if (diff.inSeconds.abs() < 60) {
      text = '1분 전';
    } else if (diff.inMinutes.abs() < 60) {
      text = diff.inMinutes.abs().toString() + '분 전';
    } else if (diff.inHours.abs() < 24) {
      text = diff.inHours.abs().toString() + ' 시간 전';
    } else if (diff.inDays.abs() < 3) {
      text = diff.inDays.abs().toString() + '일 전';
    } else {
      final createdDate = DateTime.parse(t);
      final DateFormat formatter = DateFormat('yyyy년 MM월 dd일');
      text = formatter.format(createdDate);
    }
    return text;
  }
}
