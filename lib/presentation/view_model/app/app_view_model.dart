import 'package:albanote_project/di/model/member/member_type.dart';
import 'package:albanote_project/domain/repository/local/local_shared_preferences.dart';
import 'package:albanote_project/etc/custom_class/BaseController.dart';
import 'package:albanote_project/presentation/view/login/login_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

enum PageName { workplace, community, notification, myPage }

class AppViewModel extends BaseViewModel {
  AppViewModel(this.localSharedPreferences);

  LocalSharedPreferences localSharedPreferences;

  var pageIndex = 0.obs;
  List<int> bottomHistory = [0];

  Future<MemberType?> getMemberType() async {
    var memberType = await localSharedPreferences.findMemberType();
    return memberType;
  }

  void changeBottomNave(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];
    switch (page) {
      case PageName.workplace:
      case PageName.community:
      case PageName.notification:
      case PageName.myPage:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
  }

  void _changePage(int value, {bool hasGesture = true}) {
    pageIndex(value);
    if (!hasGesture) return;
    if (bottomHistory.contains(value) && value != 0) {
      bottomHistory.remove(value);
    }
    bottomHistory.add(value);
  }

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
