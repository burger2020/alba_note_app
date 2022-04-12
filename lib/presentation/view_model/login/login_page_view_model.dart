import 'package:albanote_project/domain/repository/local/local_shared_preferences.dart';
import 'package:albanote_project/etc/custom_class/BaseController.dart';
import 'package:albanote_project/presentation/view/app/app_view.dart';
import 'package:albanote_project/presentation/view/login/select_member_type_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/repository/login/login_repository.dart';

class LoginPageViewModel extends BaseViewModel {
  LoginPageViewModel(this._loginRepository, this._localSP);

  final LoginRepository _loginRepository;
  final LocalSharedPreferences _localSP;

  void checkSelectMemberType() async {
    var memberInfo = await _localSP.findMemberInfo();
    if (memberInfo?.memberTokenInfo != null && memberInfo?.memberType == null) {
      startMemberTypeView(memberInfo);
    }
  }

  void startMemberTypeView(memberInfo){
    Get.to(const SelectMemberTypeView(), arguments: {
      'memberId': memberInfo!.id,
      'accessToken': memberInfo.memberTokenInfo!.accessToken,
    });
  }

  Future postLogin(String idToken, String accessToken) async {
    showProgress(true);
    var response = await _loginRepository.postLogin(idToken, accessToken);
    response.when(
      success: (memberInfo) {
        _localSP.updateMemberInfo(memberInfo);
        if (memberInfo.memberType == null) {
          /// 멤버 타입 안 정했을 시
          startMemberTypeView(memberInfo);
        } else {
          /// 앱 시작 화면
          Get.offAll(const AppView());
        }
        showProgress(false);
      },
      error: (e) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text('잠시 후 다시 시도해 주세요.')));
        showProgress(false);
      },
    );
  }
}
