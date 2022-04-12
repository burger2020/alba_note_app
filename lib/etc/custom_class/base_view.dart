import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'BaseController.dart';

abstract class BaseView<T extends BaseViewModel> extends GetView<T> {
  const BaseView({Key? key}) : super(key: key);

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
}
