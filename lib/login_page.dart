import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _accessToken = "";
  bool _isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: _loginNaver, child: const Text("naver login")),
          ElevatedButton(
              onPressed: _logoutNaver, child: const Text("naver logout")),
          ElevatedButton(
              onPressed: _loginKakao, child: const Text("kakao login")),
          ElevatedButton(
              onPressed: _logoutKakao, child: const Text("kakao logout")),
          ElevatedButton(
              onPressed: _loginGoogle, child: const Text("google login")),
          ElevatedButton(
              onPressed: _logoutGoogle, child: const Text("google logout")),
          Text("accessToken = $_accessToken"),
          Text("isLoggedIn = $_isLoggedIn"),
        ],
      ),
    );
  }

  void _loginKakao() async {
    if (await isKakaoTalkInstalled()) {
      try {
        var user = await UserApi.instance.loginWithKakaoTalk();
        _setLoginInfo(user);
        debugPrint('카카오톡으로 로그인 성공');
      } catch (error) {
        debugPrint('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          var user = await UserApi.instance.loginWithKakaoAccount();
          _setLoginInfo(user);
          debugPrint('카카오계정으로 로그인 성공');
        } catch (error) {
          debugPrint('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        var user = await UserApi.instance.loginWithKakaoAccount();
        _setLoginInfo(user);
        debugPrint('카카오계정으로 로그인 성공');
      } catch (error) {
        debugPrint('카카오계정으로 로그인 실패 $error');
      }
    }
  }

  void _setLoginInfo(OAuthToken user) {
    setState(() {
      _accessToken = user.accessToken;
      _isLoggedIn = true;
    });
  }

  void _logoutKakao() async {
    try {
      await UserApi.instance.logout();
      debugPrint('로그아웃 성공, SDK에서 토큰 삭제');
    } catch (error) {
      debugPrint('로그아웃 실패, SDK에서 토큰 삭제 $error');
    }
    setState(() {
      _accessToken = "";
      _isLoggedIn = false;
    });
  }

  Future<void> _loginGoogle() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn( );
      var result = await _googleSignIn.signIn();
      setState(() {
        _accessToken = result?.id ?? "";
        _isLoggedIn = result?.id != null;
      });
    } catch (error) {
      debugPrint("google signin error = " + error.toString());
    }
  }

  Future<void> _logoutGoogle() async {
    try {
      var result = await GoogleSignIn().signOut();

    } catch (error) {
      debugPrint("google signin error = " + error.toString());
    }
  }

  void _loginNaver() async {
    var isLoggedIn = await FlutterNaverLogin.isLoggedIn;
    if (isLoggedIn == true) {
      await FlutterNaverLogin.logOut();
      // var token = await FlutterNaverLogin.currentAccessToken;
      // setState(() {
      //   _accessToken = token.accessToken;
      //   _isLoggedIn = isLoggedIn;
      // });
    }
    NaverLoginResult res = await FlutterNaverLogin.logIn();
    setState(() {
      _accessToken = res.accessToken.accessToken;
      _isLoggedIn = _accessToken != "";
    });
  }

  void _logoutNaver() async {
    var isLoggedIn = await FlutterNaverLogin.isLoggedIn;
    if (isLoggedIn) {
      var result = await FlutterNaverLogin.logOut();
      setState(() {
        _accessToken = "";
        _isLoggedIn = false;
      });
    }
  }
}
