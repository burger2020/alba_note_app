import 'package:albanote_project/data/entity/login/member_login_response_dto.dart';
import 'package:albanote_project/data/repository/base_repository.dart';

import '../../../data/entity/common/response_entity.dart';

abstract class LoginRepository extends BaseRepository {
  /// 로그인
  Future<ResponseEntity<MemberLoginResponseDTO>> postLogin(String idToken, String accessToken);
}
