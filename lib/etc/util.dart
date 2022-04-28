import 'package:albanote_project/config/repository_config.dart';
import 'package:albanote_project/presentation/view/app/workplace/boss/request/boss_workplace_request_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
      text = diff.inHours.abs().toString() + '시간 전';
    } else if (diff.inDays.abs() < 3) {
      text = diff.inDays.abs().toString() + '일 전';
    } else {
      final createdDate = DateTime.parse(t);
      final DateFormat formatter = DateFormat('yyyy년 MM월 dd일');
      text = formatter.format(createdDate);
    }
    return text;
  }

  // 00:00:00 시간 두개 비교
  static String diffTimeToTime(String? s, String? e, String? b, String? nb,
      {type = AllowanceType.NORMAL, bool short = false}) {
    if (s == null || e == null) return '00시간 00분';
    var endTime = e.split(":");
    var startTime = s.split(":");
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    var eSec = (int.parse(endTime[0]) * 3600 + int.parse(endTime[1]) * 60 + int.parse(endTime[2]));
    // 야간 근무 시간 계산
    if (type == AllowanceType.NIGHT) {
      if (eSec < (3600 * 22)) {
        return "${twoDigits(0)}시간 ${twoDigits(0)}분";
      } else {
        startTime = '10:00:00'.split(":");
      }
    }
    var sSec = (int.parse(startTime[0]) * 3600 + int.parse(startTime[1]) * 60 + int.parse(startTime[2]));
    if (eSec < sSec) {
      // 종료시간이 시작시간보다 적을경우(24시 넘어서까지 근무) 24시간 추가
      eSec += (3600 * 24);
    }
    var h = (eSec - sSec) / 3600;
    var m = ((eSec - sSec) % 3600) / 60;
    // 초과 근무일 시 8시간 이하면 0시간 8시간 이상이면 -8시간 후 계산
    if (type == AllowanceType.OVER) {
      if ((eSec - sSec) < (3600 * 8)) {
        return "${twoDigits(0)}시간 ${twoDigits(0)}분";
      } else {
        h -= 8;
      }
    }
    return "${twoDigits((h.toInt()))}시간 ${twoDigits(m.toInt())}분";
  }

  // 급여 계산
  static void calcTotalSalary(
    String? s, // 시작 시간
    String? e, // 종료 시간
    bool isOver, // 초과 근무 해당 여부
    bool isNight, // 야간 수당 해당 여부
    bool isHoliday, // 휴일 수당 해당 여부
    String workedDate, // 근무 날짜
    int hourlyWage, // 시급
    int hourlyWageCalculationUnit, // 시급 계산 단위
    int? breakTime,
    int? nightBreakTime,
  ) {
    var totalWorkedTime = diffTimeToTime(s, e, null, null, type: AllowanceType.NORMAL, short: true);
    var nightWorkedTime = diffTimeToTime(s, e, null, null, type: AllowanceType.NIGHT, short: true);
    var overWorkedTime = diffTimeToTime(s, e, null, null, type: AllowanceType.OVER, short: true);
    var holidayWorkedTime = diffTimeToTime(s, e, null, null, type: AllowanceType.HOLIDAY, short: true);

  }
}
