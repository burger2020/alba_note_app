import 'package:albanote_project/data/entity/common/response_entity.dart';

import '../../data/repository/base_repository.dart';

abstract class CommonRepository extends BaseRepository {
  /// accessToken 유효한지 확인
  Future<ResponseEntity> postCheckAccessTokenValid();
}
