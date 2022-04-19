class Util {
  /// 14:00:00 -> 14:00
  String convertTimeStampToHourNMinute(String? t, {bool short = false}) {
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
}
