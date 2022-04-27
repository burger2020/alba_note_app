import 'package:albanote_project/domain/repository/remote/common_repository.dart';
import 'package:albanote_project/domain/repository/remote/member_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../config/repository_config.dart';
import '../domain/repository/local/local_shared_preferences.dart';

enum RootState { APP, LOGIN, SPLASH }

class RootController extends GetxController {
  RootController(this._localSP, this._commonRepository, this._memberRepository);

  final CommonRepository _commonRepository;
  final MemberRepository _memberRepository;
  final LocalSharedPreferences _localSP;

  Rx<RootState> get isAuth => _isAuth;
  final Rx<RootState> _isAuth = RootState.SPLASH.obs;

  @override
  void onInit() async {
    super.onInit();
    var memberInfo = await _localSP.findMemberInfo();
    if (memberInfo == null || memberInfo.memberType == null) {
      /// 로컬에 유저 기본 정보 없으면 로그인 화면으로
      _isAuth.value = RootState.LOGIN;
    } else {
      /// 로컬에 정보 있으면 서버로 access token 유효한지 확인
      var response = await _commonRepository.postCheckAccessTokenValid();
      response.when(success: (isValid) {
        _isAuth(isValid ? RootState.APP : RootState.LOGIN);
        if (isValid) {
          listenOnTokenRefresh();
          setServerTime();
        }
      }, error: (e) {
        _isAuth(RootState.LOGIN);
      });
    }
  }

  /// 서버 시간 조회
  void setServerTime() async {
    var result = await _commonRepository.getCurrentServerTime();
    result.when(
        success: (data) {
          var serverTime = DateTime.parse(data);
          RepositoryConfig.serverTimeDiff = DateTime.now().difference(serverTime).inMilliseconds;
        },
        error: (e) {});
  }

  /// fcm 토큰 새로고침 스트림
  void listenOnTokenRefresh() async {
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      await _memberRepository.putMemberFcmToken(newToken);
    });
  }

  /// 로그아웃 상태로 변경
  Future setLogoutState() async {
    FirebaseMessaging.instance.deleteToken();
    _memberRepository.postMemberLogout();
    _localSP.setLogoutState();
  }
}
