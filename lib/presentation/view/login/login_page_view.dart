import 'package:albanote_project/controller/root_controller.dart';
import 'package:albanote_project/di/model/member/social_login_type.dart';
import 'package:albanote_project/etc/custom_class/base_view.dart';
import 'package:albanote_project/presentation/view_model/login/login_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class LoginPageView extends BaseView<LoginPageViewModel> {
  const LoginPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.checkSelectMemberType();

    return progressWidget(
      child: SafeArea(
        child: Scaffold(
          body: GetBuilder<RootController>(
            builder: (rootController) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // ElevatedButton(onPressed: _loginNaver, child: const Text("naver login")),
                  // ElevatedButton(onPressed: _logoutNaver, child: const Text("naver logout")),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: const Color(0xfffee500), elevation: 0),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text("kakao login", style: TextStyle(fontSize: 18, color: Colors.black)),
                        ),
                        onPressed: () {
                          _loginKakao(rootController);
                        }),
                  ),
                  // ElevatedButton(onPressed: _logoutKakao(rootController), child: const Text("kakao logout")),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            side: const BorderSide(width: 0.5, color: Color(0x33000000)),
                            primary: Colors.white,
                            elevation: 0),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text("google login", style: TextStyle(fontSize: 18, color: Color(0x80000000))),
                        ),
                        onPressed: () {
                          _loginGoogle(rootController);
                        }),
                  ),
                  // ElevatedButton(onPressed: _logoutGoogle(rootController), child: const Text("google logout"))
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _loginKakao(RootController rootController) async {
    if (await isKakaoTalkInstalled()) {
      try {
        var user = await UserApi.instance.loginWithKakaoTalk();
        controller.postLogin(user.idToken.toString(), user.accessToken, SocialLoginType.KAKAO);
        debugPrint('?????????????????? ????????? ??????');
      } catch (error) {
        debugPrint('?????????????????? ????????? ?????? $error');
        // ???????????? ???????????? ?????? ??? ???????????? ?????? ?????? ???????????? ???????????? ????????? ??????, ???????????? ????????? ????????? ?????? ????????????????????? ????????? ?????? ?????? ????????? ????????? ?????? (???: ?????? ??????)
        if (error is PlatformException && error.code == 'CANCELED') return;
        // ??????????????? ????????? ?????????????????? ?????? ??????, ????????????????????? ?????????
        try {
          var user = await UserApi.instance.loginWithKakaoAccount();
          controller.postLogin(user.idToken.toString(), user.accessToken, SocialLoginType.KAKAO);
          debugPrint('????????????????????? ????????? ??????');
        } catch (error) {
          debugPrint('????????????????????? ????????? ?????? $error');
        }
      }
    } else {
      try {
        var user = await UserApi.instance.loginWithKakaoAccount();
        controller.postLogin(user.idToken.toString(), user.accessToken, SocialLoginType.KAKAO);
        debugPrint('????????????????????? ????????? ??????');
      } catch (error) {
        debugPrint('????????????????????? ????????? ?????? $error');
      }
    }
  }

  Future<void> _loginGoogle(RootController rootController) async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn();
      var result = await _googleSignIn.signIn();
      var user = await result!.authentication;
      controller.postLogin(user.idToken.toString(), user.accessToken.toString(), SocialLoginType.GOOGLE);
    } catch (error) {
      debugPrint("google signin error = " + error.toString());
    }
  }

// void _loginNaver() async {
//   var isLoggedIn = await FlutterNaverLogin.isLoggedIn;
//   if (isLoggedIn == true) {
//     await FlutterNaverLogin.logOut();
//     // var token = await FlutterNaverLogin.currentAccessToken;
//     // setState(() {
//     //   _accessToken = token.accessToken;
//     //   _isLoggedIn = isLoggedIn;
//     // });
//   }
//   NaverLoginResult res = await FlutterNaverLogin.logIn();
//   _accessToken = res.accessToken.accessToken;
//   _isLoggedIn = _accessToken != "";
// }
//
// void _logoutNaver() async {
//   var isLoggedIn = await FlutterNaverLogin.isLoggedIn;
//   if (isLoggedIn) {
//     var result = await FlutterNaverLogin.logOut();
//     setState(() {
//       _accessToken = "";
//       _isLoggedIn = false;
//     });
//   }
// }
}
