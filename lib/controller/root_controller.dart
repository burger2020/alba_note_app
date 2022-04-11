import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RootController extends GetxController {
  RootController();


  RxBool get isAuth => _isAuth;
  final RxBool _isAuth = false.obs;

  @override
  void onInit() async {
    super.onInit();
    final pref = await SharedPreferences.getInstance();
    _isAuth.value = pref.getBool('isAuth') ?? false;
  }

  Future<void> setLoginInfo(String idToken, String accessToken) async {
    _isAuth(true);
    final pref = await SharedPreferences.getInstance();
    pref.setBool("isAuth", true);
  }
}
