import 'package:albanote_project/data/entity/login/member_login_response_dto.dart';
import 'package:albanote_project/data/repository/base_repository.dart';
import 'package:albanote_project/di/model/member/social_login_type.dart';
import 'package:albanote_project/data/entity/common/response_entity.dart';
import 'package:albanote_project/domain/repository/local/local_shared_preferences.dart';
import 'package:dio/dio.dart';

abstract class LoginRepository extends BaseRepository {
  LoginRepository(Dio dio, LocalSharedPreferences localSP) : super(dio, localSP);

  /// 로그인
  Future<ResponseEntity<MemberLoginResponseDTO>> postLogin(String idToken, String accessToken, SocialLoginType socialType);
}
