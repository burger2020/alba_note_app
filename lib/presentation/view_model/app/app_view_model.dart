import 'package:albanote_project/domain/repository/local/local_shared_preferences.dart';
import 'package:albanote_project/etc/custom_class/BaseController.dart';
import 'package:albanote_project/presentation/view/login/login_page_view.dart';
import 'package:get/get.dart';

class AppViewModel extends BaseViewModel {
  AppViewModel(this.localSharedPreferences);

  LocalSharedPreferences localSharedPreferences;

  logout() async {
    localSharedPreferences.setLogoutState();
    Future.delayed(const Duration(seconds: 1));
    Get.offAll(const LoginPageView());
  }
}
