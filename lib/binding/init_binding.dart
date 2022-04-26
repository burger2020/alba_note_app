import 'package:albanote_project/data/repository/common_repository_impl.dart';
import 'package:albanote_project/data/repository/external_api_repository_impl.dart';
import 'package:albanote_project/data/repository/login_repository_impl.dart';
import 'package:albanote_project/data/repository/member_repository_impl.dart';
import 'package:albanote_project/data/repository/workplace_repository_impl.dart';
import 'package:albanote_project/domain/repository/local/local_shared_preferences.dart';
import 'package:albanote_project/presentation/view/app/workplace/boss/work_history/boss_workplace_work_history_list_view.dart';
import 'package:albanote_project/presentation/view_model/app/app_view_model.dart';
import 'package:albanote_project/presentation/view_model/app/workplace/boss/boss_workplace_view_model.dart';
import 'package:albanote_project/presentation/view_model/app/workplace/boss/request/boss_workplace_request_list_view_model.dart';
import 'package:albanote_project/presentation/view_model/app/workplace/boss/todo/boss_workplace_todo_list_view_model.dart';
import 'package:albanote_project/presentation/view_model/app/workplace/boss/work_history/boss_workplace_todo_list_view_model.dart';
import 'package:albanote_project/presentation/view_model/login/login_page_view_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../config/dio_interceptors.dart';
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
    var externalApiRepository = ExternalApiRepositoryImpl(dio, localSharedPreferences);

    Get.put(RootController(localSharedPreferences, commonRepository, memberRepository));
    Get.put(BottomNavController(), permanent: true);
    Get.lazyPut(() => AppViewModel(localSharedPreferences));
    Get.lazyPut(() => LoginPageViewModel(loginRepository, localSharedPreferences, memberRepository));

    Get.lazyPut(() => BossWorkplaceMainViewModel(workplaceOfBossRepository, externalApiRepository));

    Get.put(BossWorkplaceRequestViewModel(workplaceOfBossRepository)); // 일터 요청 리스트
    Get.put(BossWorkplaceWorkHistoryListViewModel(workplaceOfBossRepository)); // 일터 근무 기록 리스트
    Get.put(BossWorkplaceTodoListViewModel(workplaceOfBossRepository)); // 일터 할일 리스트
  }
}
