import 'package:albanote_project/data/entity/login/member_login_response_dto.dart';
import 'package:albanote_project/di/model/member/social_login_type.dart';

import '../../../data/entity/response_entity.dart';

abstract class LoginRepository {
  /// 로그인
  Future<ResponseEntity<MemberLoginResponseDTO>> postLogin(String idToken, String accessToken, SocialLoginType socialType);
}
