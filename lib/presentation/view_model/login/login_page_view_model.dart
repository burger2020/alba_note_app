import 'package:albanote_project/di/model/member/member_type.dart';
import 'package:albanote_project/di/model/member/social_login_type.dart';
import 'package:albanote_project/domain/repository/local/local_shared_preferences.dart';
import 'package:albanote_project/domain/repository/remote/member_repository.dart';
import 'package:albanote_project/etc/custom_class/BaseController.dart';
import 'package:albanote_project/presentation/view/app/app_view.dart';
import 'package:albanote_project/presentation/view/login/select_member_type_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../../../domain/repository/remote/login_repository.dart';

class LoginPageViewModel extends BaseViewModel {
  LoginPageViewModel(this._loginRepository, this._localSP, this._memberRepository);

  final LoginRepository _loginRepository;
  final MemberRepository _memberRepository;
  final LocalSharedPreferences _localSP;

  /// 로그인
  Future postLogin(String idToken, String accessToken, SocialLoginType socialType) async {
    showProgress(true);
    var response = await _loginRepository.postLogin(idToken, accessToken, socialType);
    response.when(success: (memberInfo) async {
      _localSP.updateMemberInfo(memberInfo);
      if (memberInfo.memberType == null) {
        /// 멤버 타입 안 정했을 시
        startMemberTypeView(memberInfo);
      } else {
        /// 로그인 완료
        loginDone();
      }
    }, error: (e) {
      showSnackBarByMessage();
    });
    showProgress(false);
  }

  /// 멤버 종류 선택
  Future putSelectMemberType(MemberType memberType) async {

    showProgress(true);
    Future.delayed(const Duration(milliseconds: 500));
    var response = await _memberRepository.putSelectMemberType(memberType);
    response.when(success: (result) async {
      await _localSP.updateMemberType(memberType);
      loginDone();
    }, error: (e) {
      showSnackBarByMessage();
    });
    showProgress(false);
  }

  /// 로그인 성공
  void loginDone() async {
    var fcmToken = await FirebaseMessaging.instance
        .getToken(vapidKey: 'BIhke2ggQ2CIRV5ykzSwXenuNWGZ_o8hB-dWAXvLeCdHG4AcniFsiQ8A_8DyfIlxwVy5jJOSjAmWEzyPyThSEPI');
    _memberRepository.putMemberFcmToken(fcmToken!);
    Get.offAll(const AppView());
  }

  /// 멤버 선택했는지 확인
  void checkSelectMemberType() async {
    var memberInfo = await _localSP.findMemberInfo();
    if (memberInfo?.memberTokenInfo != null && memberInfo?.memberType == null) {
      startMemberTypeView(memberInfo);
    } else {}
  }

  /// 멤버 타입 선택 화면으로 전환
  void startMemberTypeView(memberInfo) {
    Get.to(const SelectMemberTypeView(), arguments: {
      'memberId': memberInfo!.id,
      'accessToken': memberInfo.memberTokenInfo!.accessToken,
    });
  }
}
