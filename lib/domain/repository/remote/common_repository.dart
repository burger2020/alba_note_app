import 'package:albanote_project/data/entity/common/response_entity.dart';
import 'package:albanote_project/data/entity/login/member_token_info_dto.dart';
import 'package:albanote_project/data/repository/base_repository.dart';
import 'package:albanote_project/domain/repository/local/local_shared_preferences.dart';
import 'package:dio/dio.dart';

abstract class CommonRepository extends BaseRepository {
  CommonRepository(Dio dio, LocalSharedPreferences localSP) : super(dio, localSP);

  /// 서버 시간 조회
  Future<ResponseEntity<String>> getCurrentServerTime();

  /// accessToken 유효한지 확인
  Future<ResponseEntity<bool>> postCheckAccessTokenValid();
}
