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

  var isOnlyIncomplete = false.obs;

  Rx<PageRequestModel> pageRequest = PageRequestModel().obs;
  RxList<WorkplaceRequestSimpleResponseDTO> workplaceRequests = RxList<WorkplaceRequestSimpleResponseDTO>();

  @override
  void onInit() {
    super.onInit();
    setPaginationScroll(scrollController, pageRequest.value, () => getWorkplaceRequestList());
  }

  /// 일터 요청 조회
  Future getWorkplaceRequestList() async {
    showProgress(true);
    pageRequest.value.isLoading = true;
    var response = await _workplaceOfBossRepository.getWorkplaceRequestList(
        workplaceId, pageRequest.value, isOnlyIncomplete.value);
    response.when(success: (data) {
      data.sort((a, b) => b.createdDate!.compareTo(a.createdDate!));
      workplaceRequests.addAll(data);
      pageRequest.value.setResult(data);
      pageRequest(pageRequest.value);
      showProgress(false);
    }, error: (e) {
      pageRequest.value.isLoading = false;
      showProgress(false);
    });
  }

  /// 요청 상세화면 전환
  void startRequestDetailView(int requestId) {
    Get.to(const BossWorkplaceRequestDetailView(), binding: BindingsBuilder((() {
      BossWorkplaceRequestDetailViewModel(_workplaceOfBossRepository, requestId);
    })));
  }

  /// 필터 상태 변경
  void onFilterChange(bool value) {
    if (isOnlyIncomplete.value == value) return;
    isOnlyIncomplete(value);
    onRefreshRequestList();
  }

  /// 새로고침
  void onRefreshRequestList() {
    pageRequest.value.setRefresh();
    workplaceRequests.clear();
    getWorkplaceRequestList();
  }
}
