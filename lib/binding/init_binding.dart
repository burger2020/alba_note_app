import 'package:albanote_project/data/repository/dio_interceptors.dart';
import 'package:albanote_project/data/repository/login/common_repository_impl.dart';
import 'package:albanote_project/data/repository/login/login_repository_impl.dart';
import 'package:albanote_project/domain/repository/local/local_shared_preferences.dart';
import 'package:albanote_project/presentation/view_model/app/app_view_model.dart';
import 'package:albanote_project/presentation/view_model/login/login_page_view_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../controller/bottom_nav_controller.dart';
import '../controller/root_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    var dio = Dio();
    dio.interceptors.add(DioInterceptors());

    var localSharedPreferences = LocalSharedPreferences();

    var commonRepository = CommonRepositoryImpl(dio, localSharedPreferences);
    var loginRepository = LoginRepositoryImpl(dio);

    Get.put(RootController(localSharedPreferences, commonRepository));
    Get.put(BottomNavController(), permanent: true);
    Get.put(AppViewModel(localSharedPreferences));
    Get.put(LoginPageViewModel(loginRepository, localSharedPreferences), permanent: true);
  }
}
