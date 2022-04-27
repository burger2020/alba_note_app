class RepositoryConfig {
  static int serverTimeDiff = 0;

  /// 서버 시간 차이 계산해서 현재 시간 계산
  static DateTime getCurrentTime() {
    return DateTime.now().subtract(Duration(milliseconds: serverTimeDiff));
  }

  // static const serverUrl = 'http://172.30.1.52:8000'; // 집 서버
  static const serverUrl = 'http://172.31.98.147:8000';
  static const basicToken = 'Basic YWxiYW5vdGVfaWRfYmxhYzphbGJhbm90ZV9wd2RfMjAxMw==';
}
