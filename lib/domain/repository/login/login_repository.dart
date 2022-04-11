import '../../../data/entity/response_entity.dart';

abstract class LoginRepository {
  /// 로그인
  Future<ResponseEntity<bool>> postLogin(String idToken, String accessToken);
}
