import 'package:albanote_project/data/entity/common/response_entity.dart';
import 'package:albanote_project/data/entity/workplace_of_boss/workplace_info_of_boss_response_dto.dart';
import 'package:albanote_project/data/entity/workplace_of_boss/workplace_request_simple_response_dto.dart';
import 'package:albanote_project/data/repository/base_repository.dart';
import 'package:albanote_project/domain/model/page_request_model.dart';
import 'package:albanote_project/domain/repository/local/local_shared_preferences.dart';
import 'package:dio/dio.dart';

abstract class WorkplaceOfBossRepository extends BaseRepository {
  WorkplaceOfBossRepository(Dio dio, LocalSharedPreferences localSP) : super(dio, localSP);

  /// 대표 일터 조회
  /// @param workplaceId - null 이면 대표 일터
  Future<ResponseEntity<WorkplaceInfoOfBossResponseDTO>> getWorkplaceInfoOfBoss(int? workplaceId);

  /// 일터 목록 조회
  Future getWorkplaceList(int memberId);

  /// 일터 리스트 조회
  Future<ResponseEntity<List<WorkplaceRequestSimpleResponseDTO>>> getWorkplaceRequestList(
      int workplaceId, PageRequestModel pageRequest, bool isIncomplete);
}
