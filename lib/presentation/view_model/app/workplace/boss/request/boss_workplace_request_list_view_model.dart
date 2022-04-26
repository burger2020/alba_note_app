import 'package:albanote_project/data/entity/response/workplace_of_boss/workplace_request_simple_response_dto.dart';
import 'package:albanote_project/domain/model/page_request_model.dart';
import 'package:albanote_project/domain/repository/remote/workplace_repository.dart';
import 'package:albanote_project/etc/custom_class/BaseController.dart';
import 'package:albanote_project/presentation/view/app/workplace/boss/request/boss_workplace_request_detail_view.dart';
import 'package:albanote_project/presentation/view_model/app/workplace/boss/request/boss_workplace_request_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BossWorkplaceRequestViewModel extends BaseViewModel {
  BossWorkplaceRequestViewModel(this._workplaceOfBossRepository);

  final WorkplaceOfBossRepository _workplaceOfBossRepository;
  late int workplaceId;

  final scrollController = ScrollController();

  PageRequestModel pageRequest = PageRequestModel();
  RxList<WorkplaceRequestSimpleResponseDTO> workplaceRequests = RxList<WorkplaceRequestSimpleResponseDTO>();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (pageRequest.isLast) return;
      if (scrollController.position.extentAfter <= 0 && pageRequest.isLoading == false) {
        print('하단');
      }
    });
  }

  /// 일터 요청 조회
  Future getWorkplaceRequestList() async {
    var response = await _workplaceOfBossRepository.getWorkplaceRequestList(workplaceId, pageRequest, false);
    response.when(
        success: (data) {
          workplaceRequests.addAll(data);
          pageRequest.setResult(data);
        },
        error: (e) {});
  }

  /// 요청 상세화면 전환
  void startRequestDetailView(int requestId) {
    Get.to(const BossWorkplaceRequestDetailView(), binding: BindingsBuilder((() {
      BossWorkplaceRequestDetailViewModel(_workplaceOfBossRepository, requestId);
    })));
  }
}
