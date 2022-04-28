import 'package:albanote_project/data/entity/response/workplace_of_boss/workplace_request_detail_response_dto.dart';
import 'package:albanote_project/domain/repository/remote/workplace_repository.dart';
import 'package:albanote_project/etc/custom_class/BaseController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BossWorkplaceRequestDetailViewModel extends BaseViewModel {
  BossWorkplaceRequestDetailViewModel(this._workplaceOfBossRepository, this.requestId);

  final WorkplaceOfBossRepository _workplaceOfBossRepository;
  final int requestId;

  var requestDetail = WorkplaceRequestDetailResponseDTO().obs;

  var memoController = TextEditingController();
  var inputMemo = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    getWorkplaceRequestDetail();
  }

  /// 일터 요청 상세 조회
  Future getWorkplaceRequestDetail() async {
    showProgress(true);
    var result = await _workplaceOfBossRepository.getWorkplaceRequestDetail(requestId);
    result.when(success: (data) {
      showProgress(false);
      memoController.text = data.memo ?? '';
      inputMemo(data.memo ?? '');
      requestDetail(data);
    }, error: (e) {
      showProgress(false);
      showSnackBarByMessage();
    });
  }

  /// 요청 응답
  Future putRequestResponse(bool isComplete) async {
    var result = await _workplaceOfBossRepository.putRequestResponse(requestDetail.value.requestId!, isComplete);
    result.when(success: (data) {
      requestDetail(requestDetail.value.copyWith(isComplete: isComplete));
    }, error: (e) {
      showSnackBarByMessage();
    });
  }

  // 메모 변경
  void onChangedMemo(String memo) {
    inputMemo.value = memo;
  }

  void setMemoText() async {
    var result = await _workplaceOfBossRepository.putChangRequestMemo(requestId, inputMemo.value);
    result.when(success: (data) {
      requestDetail(requestDetail.value.copyWith(memo: inputMemo.value));
    }, error: (e) {
      showSnackBarByMessage();
    });
  }

  void backPress() {
    Get.back(result: {'memo': inputMemo.value, 'requestId': requestId, 'isComplete': requestDetail.value.isComplete});
  }
}
