import 'package:albanote_project/domain/model/coordinate_model.dart';
import 'package:albanote_project/domain/repository/remote/external_api_repository.dart';
import 'package:albanote_project/domain/repository/remote/workplace_repository.dart';
import 'package:albanote_project/etc/custom_class/BaseController.dart';
import 'package:albanote_project/presentation/view/app/workplace/boss/create_workplace/workplace_boss_info_input_view.dart';
import 'package:albanote_project/presentation/view/app/workplace/boss/create_workplace/workplace_business_input_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';

class CreateWorkplaceViewModel extends BaseViewModel {
  CreateWorkplaceViewModel(this._workplaceOfBossRepository, this._externalApiRepository);

  final WorkplaceOfBossRepository _workplaceOfBossRepository;
  final ExternalApiRepository _externalApiRepository;

  var workplaceName = ''.obs;
  var workplaceAddress = ''.obs;
  var addressController = TextEditingController();
  var workplaceDetailAddress = ''.obs;

  var bossName = ''.obs;
  var bossRankName = ''.obs;
  var bossPhoneNumber = ''.obs;

  var businessNumber = ''.obs;
  var bossNameOfBusiness = ''.obs;
  var openingDateOfBusiness = ''.obs;
  var openingDateController = TextEditingController();
  var businessName = ''.obs;
  var isCorporateBusiness = false.obs;
  var typeObBusiness = ''.obs;

  RxBool isCommuteRangeSet = false.obs;
  RxInt selectRadius = 25.obs;
  Rx<CoordinateModel> selectCoord = CoordinateModel(null, null).obs;
  RxList<CircleOverlay> selectLocationOverlay = RxList<CircleOverlay>();

  Future<String?> getAccessToken() async {
    return await _workplaceOfBossRepository.localSP.accessToken;
  }

  /// 일터 사장님 정보 입력 화면으로 이동
  void startCreateWorkplaceInputBossInfoView() {
    Get.to(const WorkplaceBossInfoInputView(), binding: BindingsBuilder(() => {Get.put(this)}));
  }

  /// 사업자 정보 입력 화면으로 이동
  void startWorkplaceBusinessInputView() {
    Get.to(const WorkplaceBusinessInputView(), binding: BindingsBuilder(() => {Get.put(this)}));
  }

  /// 사업자 정보 검증
  void postCheckBusiness() async {
    var businessName = this.businessName.value;
    if (isCorporateBusiness.value && !businessName.contains('(주)')) businessName += '(주) ';

    var result = await _externalApiRepository.postCheckBusiness(
      businessNumber.value.replaceAll('-', ''),
      openingDateOfBusiness.value,
      bossNameOfBusiness.value,
      businessName,
      typeObBusiness.value,
    );
    result.when(
        success: (data) {
          print('check business result = ' + data.data.toString());
        },
        error: (e) {});
  }
}
