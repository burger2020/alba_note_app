import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'BaseController.dart';

abstract class BaseView<T extends BaseViewModel> extends GetView<T> {
  const BaseView({Key? key}) : super(key: key);

  /// overscroll never
  Widget disallowIndicatorWidget({required Widget child}) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowIndicator();
        return true;
      },
      child: child,
    );
  }

  /// 기본 앱바 생성
  AppBar buildBaseAppBar({required String title, TextStyle? textStyle, leadIcon = Icons.close, List<Widget>? actions}) {
    return AppBar(
      backgroundColor: Colors.white,
      actions: actions ?? [],
      elevation: 0,
      title: Text(title, style: textStyle ?? const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      centerTitle: true,
      leading: GestureDetector(child: Icon(leadIcon, color: Colors.black), onTap: () => Get.back()),
      shape: const Border(bottom: BorderSide(color: Colors.black12)),
    );
  }

  /// 프로그래스
  Widget progressWidget({required Widget child}) {
    return Stack(children: [
      child,
      Obx(() {
        return controller.isProgress
            ? Container(
                child: const Center(child: CircularProgressIndicator()),
                decoration: const BoxDecoration(color: Colors.black54))
            : Container();
      }),
    ]);
  }

  buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void showAlertDialog(
      {String? title,
      required String content,
      String positiveButtonText = "확인",
      String negativeBtnText = '취소',
      Function? setOnPositiveListener,
      Function? setOnNegativeListener,
      bool barrierDismissible = true}) {
    showDialog(
        context: Get.context!,
        barrierDismissible: barrierDismissible, //Dialog를 제외한 다른 화면 터치 x
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title
            title: title == null ? null : Column(children: [Text(title)]),
            content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(content)]),
            actions: <Widget>[
              TextButton(
                child: Text(negativeBtnText),
                onPressed: () {
                  setOnNegativeListener?.call();
                  Get.back();
                },
              ),
              TextButton(
                child: Text(positiveButtonText),
                onPressed: () {
                  setOnPositiveListener?.call();
                  Get.back();
                },
              ),
            ],
          );
        });
  }
}
