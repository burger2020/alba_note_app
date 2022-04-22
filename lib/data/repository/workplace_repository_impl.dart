import 'dart:convert';

import 'package:albanote_project/config/repository_config.dart';
import 'package:albanote_project/data/entity/common/response_entity.dart';
import 'package:albanote_project/data/entity/workplace_of_boss/workplace_info_of_boss_response_dto.dart';
import 'package:albanote_project/data/entity/workplace_of_boss/workplace_request_simple_response_dto.dart';
import 'package:albanote_project/domain/model/page_request_model.dart';
import 'package:albanote_project/domain/repository/local/local_shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

import '../../domain/repository/remote/workplace_repository.dart';

/// 사장님 일터 조회
class WorkplaceOfBossRepositoryImpl extends WorkplaceOfBossRepository {
  WorkplaceOfBossRepositoryImpl(Dio dio, LocalSharedPreferences localSP) : super(dio, localSP);

  static const _baseUri = RepositoryConfig.serverUrl + '/workplace';

  /// 대표 일터 조회
  /// @param workplaceId - null 이면 대표 일터
  @override
  Future<ResponseEntity<WorkplaceInfoOfBossResponseDTO>> getWorkplaceInfoOfBoss(int? workplaceId) async {
    const uri = _baseUri + '/workplaceInfoOfBoss';
    try {
      var accessToken = await localSP.accessToken;
      var memberId = await localSP.memberId;
      var response = await dio.get(uri,
          queryParameters: {'memberId': memberId, 'workplaceId': workplaceId},
          options: Options(headers: {'Authorization': accessToken}));
      if (response.statusCode == HttpStatus.ok) {
        var result = WorkplaceInfoOfBossResponseDTO.fromJson(Map<String, dynamic>.from(response.data));
        return ResponseEntity.success(result);
      } else {
        return onErrorHandler(response);
      }
    } on DioError catch (e) {
      return onDioErrorHandler(e);
    }
  }

  @override
  Future getWorkplaceList(int memberId) async {}

  /// 일터 리스트 조회
  @override
  Future<ResponseEntity<List<WorkplaceRequestSimpleResponseDTO>>> getWorkplaceRequestList(
    int workplaceId,
    PageRequestModel pageRequest,
    bool isIncomplete,
  ) async {
    const uri = _baseUri + '/requestList';
    try {
      var accessToken = await localSP.accessToken;
      var response = await dio.get(uri,
          queryParameters: {'workplaceId': workplaceId, 'isIncomplete': isIncomplete, ...pageRequest.getRequestParam()},
          options: Options(headers: {'Authorization': accessToken}));
      if (response.statusCode == HttpStatus.ok) {
        var result = List<Map<String, dynamic>>.from(response.data)
            .map((e) => WorkplaceRequestSimpleResponseDTO.fromJson(e))
            .toList();
        return ResponseEntity.success(result);
      } else {
        return onErrorHandler(response);
      }
    } on DioError catch (e) {
      return onDioErrorHandler(e);
    }
  }
}
