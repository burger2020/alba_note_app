import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseViewModel extends GetxController {
  bool get isProgress => _isProgress.value;
  final RxBool _isProgress = false.obs;

  /// 프로그래스 출력
  void showProgress(bool progress) {
    _isProgress(progress);
  }

  /// 스낵바 출력
  void showSnackBarByMessage({String message = '잠시 후 다시 시도해 주세요.'}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(message)));
  }
}
