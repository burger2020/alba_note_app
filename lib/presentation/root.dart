import 'package:albanote_project/controller/root_controller.dart';
import 'package:albanote_project/presentation/view/login/login_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view/app/app_view.dart';

class Root extends GetView<RootController> {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.isAuth.value) {
        case RootState.APP:
          return const AppView();
        case RootState.LOGIN:
          return onLogout();
        default:
          return Scaffold(body: Container(color: Colors.orange));
      }
    });
  }

  Widget onLogout() {
    controller.setLogoutState();
    return const LoginPageView();
  }
}
