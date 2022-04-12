import 'package:albanote_project/domain/repository/common_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/repository/local/local_shared_preferences.dart';

class RootController extends GetxController {
  RootController(this._localSP, this._commonRepository);

  final CommonRepository _commonRepository;
  final LocalSharedPreferences _localSP;

  RxBool get isAuth => _isAuth;
  final RxBool _isAuth = false.obs;

  @override
  void onInit() async {
    super.onInit();
    var memberInfo = await _localSP.findMemberInfo();
    if (memberInfo != null && memberInfo.memberType != null) {
      _isAuth.value = true;
    } else {
      /// access token 유효한지 확인
      var response = await _commonRepository.postCheckAccessTokenValid();
      response.when(success: (isValid) {
        _isAuth(isValid);
      }, error: (e) {
        _isAuth(false);
      });
    }
  }

  Future<void> setLoginInfo(String idToken, String accessToken) async {
    _isAuth(true);
    final pref = await SharedPreferences.getInstance();
    pref.setBool("isAuth", true);
  }

  Future setLogoutState() async {
    await _localSP.setLogoutState();
  }
}
