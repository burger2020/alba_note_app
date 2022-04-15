import 'package:albanote_project/data/repository/base_repository.dart';
import 'package:albanote_project/domain/repository/local/local_shared_preferences.dart';
import 'package:dio/src/dio.dart';

abstract class WorkplaceOfBossRepository extends BaseRepository {
  WorkplaceOfBossRepository(Dio dio, LocalSharedPreferences localSP) : super(dio, localSP);

  /// 일터 정보 조회
  Future getWorkplaceInfo(int memberId, int? workplaceId);

  /// 일터 목록 조회
  Future getWorkplaceList(int memberId);
}
