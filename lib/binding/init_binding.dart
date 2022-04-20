import 'package:albanote_project/data/repository/config/dio_interceptors.dart';
import 'package:albanote_project/data/repository/common_repository_impl.dart';
import 'package:albanote_project/data/repository/login_repository_impl.dart';
import 'package:albanote_project/data/repository/member_repository_impl.dart';
import 'package:albanote_project/data/repository/workplace_repository_impl.dart';
import 'package:albanote_project/domain/repository/local/local_shared_preferences.dart';
import 'package:albanote_project/domain/repository/remote/workplace_repository.dart';
import 'package:albanote_project/presentation/view/app/workplace/boss/boss_workplace_container_view.dart';
import 'package:albanote_project/presentation/view_model/app/app_view_model.dart';
import 'package:albanote_project/presentation/view_model/app/workplace/boss/boss_workplace_request_list_view_model.dart';
import 'package:albanote_project/presentation/view_model/app/workplace/boss/boss_workplace_view_model.dart';
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
    var loginRepository = LoginRepositoryImpl(dio, localSharedPreferences);
    var memberRepository = MemberRepositoryImpl(dio, localSharedPreferences);
    var workplaceOfBossRepository = WorkplaceOfBossRepositoryImpl(dio, localSharedPreferences);

    Get.put(RootController(localSharedPreferences, commonRepository, memberRepository));
    Get.put(BottomNavController(), permanent: true);
    Get.lazyPut(() => AppViewModel(localSharedPreferences));
    Get.lazyPut(() => LoginPageViewModel(loginRepository, localSharedPreferences, memberRepository));

    Get.lazyPut(() =>BossWorkplaceMainViewModel(workplaceOfBossRepository));
  }
}
