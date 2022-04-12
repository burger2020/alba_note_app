import 'package:albanote_project/data/entity/login/member_login_response_dto.dart';

import '../../../data/entity/response_entity.dart';

abstract class LoginRepository {
  /// 로그인
  Future<ResponseEntity<MemberLoginResponseDTO>> postLogin(String idToken, String accessToken);
}
