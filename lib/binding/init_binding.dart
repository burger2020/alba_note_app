import 'package:albanote_project/data/repository/login/login_repository_impl.dart';
import 'package:albanote_project/presentation/view_model/login/login_page_view_model.dart';
import 'package:get/get.dart';

import '../controller/bottom_nav_controller.dart';
import '../controller/root_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RootController());
    Get.put(BottomNavController(), permanent: true);

    var loginRepository = LoginRepositoryImpl();
    Get.put(LoginPageViewModel(loginRepository), permanent: true);
  }
}
