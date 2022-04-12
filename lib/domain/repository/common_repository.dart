import 'package:albanote_project/data/entity/response_entity.dart';

abstract class CommonRepository {
  /// accessToken 유효한지 확인
  Future<ResponseEntity<bool>> postCheckAccessTokenValid();
}
