import 'package:albanote_project/domain/repository/local/local_shared_preferences.dart';
import 'package:albanote_project/etc/custom_class/BaseController.dart';
import 'package:albanote_project/presentation/view/login/login_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class AppViewModel extends BaseViewModel {
  AppViewModel(this.localSharedPreferences);

  LocalSharedPreferences localSharedPreferences;

  /// 로그아웃
  logout() async {
    try {
      await GoogleSignIn().signOut();
    } catch (error) {
      debugPrint("google signin error = " + error.toString());
    }
    try {
      await UserApi.instance.logout();
      debugPrint('로그아웃 성공, SDK에서 토큰 삭제');
    } catch (error) {
      debugPrint('로그아웃 실패, SDK에서 토큰 삭제 $error');
    }
    localSharedPreferences.setLogoutState();
    Future.delayed(const Duration(seconds: 1));
    Get.offAll(const LoginPageView());
  }
}
