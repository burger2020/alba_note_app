import 'package:albanote_project/data/entity/response/workplace_of_boss/workplace_info_of_boss_response_dto.dart';
import 'package:albanote_project/domain/repository/remote/external_api_repository.dart';
import 'package:albanote_project/domain/repository/remote/workplace_repository.dart';
import 'package:albanote_project/etc/custom_class/BaseController.dart';
import 'package:albanote_project/etc/error_codes.dart';
import 'package:albanote_project/presentation/view/app/workplace/boss/create_workplace/create_workplace_view.dart';
import 'package:albanote_project/presentation/view/app/workplace/boss/request/boss_workplace_request_list_view.dart';
import 'package:albanote_project/presentation/view/app/workplace/boss/todo/boss_workplace_todo_list_view.dart';
import 'package:albanote_project/presentation/view/app/workplace/boss/work_history/boss_workplace_work_history_list_view.dart';
import 'package:albanote_project/presentation/view_model/app/workplace/boss/create_workplace_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 사장 일터
class BossWorkplaceMainViewModel extends BaseViewModel {
  BossWorkplaceMainViewModel(this._workplaceOfBossRepository, this._externalApiRepository);

  final WorkplaceOfBossRepository _workplaceOfBossRepository;
  final ExternalApiRepository _externalApiRepository;

  Rx<WorkplaceInfoOfBossResponseDTO> workplace = WorkplaceInfoOfBossResponseDTO().obs;
  Rx<bool> isEmpty = false.obs;

  @override
  void onInit() {
    super.onInit();
    _getWorkplaceInfoOfBoss(null);
  }

  /// 사장님 일터 조회
  Future _getWorkplaceInfoOfBoss(int? workplaceId) async {
    showProgress(true);
    var result = await _workplaceOfBossRepository.getWorkplaceInfoOfBoss(workplaceId);
    result.when(success: (data) {
      workplace(data);
      isEmpty(false);
      showProgress(false);
    }, error: (e) {
      debugPrint("${e.message} , ${e.code}");
      if (e.code == notExistWorkplaceException) {
        /// 일터 없음
        isEmpty(true);
        showProgress(false);
      }
    });
  }

  /// 할일 리스트 화면으로 이동

  void startTodoListView() {
    Get.to(const BossWorkplaceTodoListView(), arguments: {'workplaceId': workplace.value.workplaceId!});
  }

  /// 근무 내역 리스트 화면으로 이동
  void startWorkHistoryListView() {
    Get.to(const BossWorkplaceWorkHistoryListView(), arguments: {'workplaceId': workplace.value.workplaceId!});
  }

  /// 요청 리스트 화면으로 이동
  void startRequestListView() {
    Get.to(const BossWorkplaceRequestListView(), arguments: {'workplaceId': workplace.value.workplaceId!});
  }

  /// 사장 일터 생성화면 이동
  startCreateWorkplaceView() async {
    var result = await Get.to(const CreateWorkplaceView(),
        binding: BindingsBuilder(
            () => {Get.put(CreateWorkplaceViewModel(_workplaceOfBossRepository, _externalApiRepository))}));
    if (result != null) {
      var workplaceId = (result as Map<String, int>)['createdWorkplaceId'];
      _getWorkplaceInfoOfBoss(workplaceId);
    }
  }
}
