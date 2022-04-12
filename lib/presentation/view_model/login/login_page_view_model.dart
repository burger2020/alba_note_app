import 'package:get/get.dart';

import '../../../domain/repository/login/login_repository.dart';

class LoginPageViewModel extends GetxController {
  LoginPageViewModel(this._loginRepository);

  final LoginRepository _loginRepository;

  Future postLogin(String idToken, String accessToken) async {
    var response = await _loginRepository.postLogin(idToken, accessToken);
    response.when(success: (data) {
      print('success : $data');
    }, error: (e) {
      print('error : $e');
    });
  }
}