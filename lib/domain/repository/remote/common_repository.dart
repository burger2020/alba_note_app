import 'package:albanote_project/data/entity/login/member_token_info_dto.dart';
import 'package:albanote_project/data/entity/response_entity.dart';

abstract class CommonRepository {
  /// accessToken 유효한지 확인
  Future<ResponseEntity<bool>> postCheckAccessTokenValid();
  /// 토큰 새로고침
  Future<ResponseEntity<MemberTokenInfoDTO>> postRefreshToken();
}
