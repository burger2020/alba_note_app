import 'package:albanote_project/controller/root_controller.dart';
import 'package:albanote_project/presentation/view/login/login_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view/app/app_view.dart';

class Root extends GetView<RootController> {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isAuth.value ? const AppView() : onLogout());
  }

  Widget onLogout(){
    controller.setLogoutState();
    return const LoginPageView();
  }
}
