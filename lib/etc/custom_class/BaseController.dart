import 'package:albanote_project/domain/model/page_request_model.dart';
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

  /// 스크롤 하단에 닿으면 페이징
  void setPaginationScroll(ScrollController controller, PageRequestModel pageRequest, Function request) {
    controller.addListener(() {
      if (pageRequest.isLast) return;
      if (controller.position.extentAfter <= 10 && pageRequest.isLoading == false) {
        // print('하단 = ' + controller.position.extentAfter.toString());
        request.call();
      }
    });
  }
}
