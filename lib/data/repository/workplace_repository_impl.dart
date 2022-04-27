import 'dart:convert';

import 'package:albanote_project/config/repository_config.dart';
import 'package:albanote_project/data/entity/common/response_entity.dart';
import 'package:albanote_project/data/entity/request/workplace_of_boss/create_workplace_request_dto.dart';
import 'package:albanote_project/data/entity/response/workplace_of_boss/workplace_info_of_boss_response_dto.dart';
import 'package:albanote_project/data/entity/response/workplace_of_boss/workplace_request_detail_response_dto.dart';
import 'package:albanote_project/data/entity/response/workplace_of_boss/workplace_request_simple_response_dto.dart';
import 'package:albanote_project/data/repository/base_repository.dart';
import 'package:albanote_project/domain/model/page_request_model.dart';
import 'package:albanote_project/domain/repository/local/local_shared_preferences.dart';
import 'package:dio/dio.dart';

import '../../domain/repository/remote/workplace_repository.dart';

/// 사장님 일터 조회
class WorkplaceOfBossRepositoryImpl extends WorkplaceOfBossRepository {
  WorkplaceOfBossRepositoryImpl(Dio dio, LocalSharedPreferences localSP) : super(dio, localSP);

  static const _baseUri = RepositoryConfig.serverUrl + '/workplace';

  /// 일터 상세 조회
  /// @param workplaceId - null 이면 대표 일터
  @override
  Future<ResponseEntity<WorkplaceInfoOfBossResponseDTO>> getWorkplaceInfoOfBoss(int? workplaceId) async {
    const uri = _baseUri + '/workplaceInfoOfBoss';
    var accessToken = await localSP.accessToken;
    var memberId = await localSP.memberId;

    return request<Map<String, dynamic>, WorkplaceInfoOfBossResponseDTO>(
      uri: uri,
      method: HttpMethod.GET,
      queryParameter: {'memberId': memberId, 'workplaceId': workplaceId},
      authorization: accessToken,
      onSuccess: (data) {
        var dto = WorkplaceInfoOfBossResponseDTO.fromJson(Map<String, dynamic>.from(data));
        return successDTO(dto);
      },
      onError: (error) => error,
    );
  }

  /// 일터 리스트 조회
  @override
  Future getWorkplaceList(int memberId) async {}

  /// 일터 요청 리스트 조회
  @override
  Future<ResponseEntity<List<WorkplaceRequestSimpleResponseDTO>>> getWorkplaceRequestList(int workplaceId,
      PageRequestModel pageRequest,
      bool isIncomplete,) async {
    const uri = _baseUri + '/requestList';
    var accessToken = await localSP.accessToken;

    return await request<List<Map<String, dynamic>>, List<WorkplaceRequestSimpleResponseDTO>>(
      uri: uri,
      method: HttpMethod.GET,
      queryParameter: {'workplaceId': workplaceId, 'isIncomplete': isIncomplete, ...pageRequest.getRequestParam()},
      authorization: accessToken,
      onSuccess: (data) {
        var dto =
        List<Map<String, dynamic>>.from(data).map((e) => WorkplaceRequestSimpleResponseDTO.fromJson(e)).toList();
        return successDTO(dto);
      },
      onError: (error) => error,
    );
  }

  /// 일터 요청 상세 조회
  @override
  Future<ResponseEntity<WorkplaceRequestDetailResponseDTO>> getWorkplaceRequestDetail(int requestId) async {
    const uri = _baseUri + '/requestDetail';
    var accessToken = await localSP.accessToken;

    return await request<Map<String, dynamic>, WorkplaceRequestDetailResponseDTO>(
      uri: uri,
      method: HttpMethod.GET,
      queryParameter: {'requestId': requestId},
      authorization: accessToken,
      onSuccess: (data) {
        var dto = WorkplaceRequestDetailResponseDTO.fromJson(Map<String, dynamic>.from(data));
        return successDTO(dto);
      },
      onError: (error) => error,
    );
  }

  /// ************************ post ********************/

  /// 일터 생성
  @override
  Future<ResponseEntity<int>> postCreateWorkplace(CreateWorkplaceRequestDTO dto) async {
    const uri = _baseUri + '/createWorkplace';
    var accessToken = await localSP.accessToken;
    var memberId = await localSP.memberId;

    return await request<int, int>(
        uri: uri,
        method: HttpMethod.POST,
        body: jsonEncode(dto.copyWith(bossMemberId: memberId).toJson()),
        authorization: accessToken,
        onSuccess: (data) => successDTO(data),
        onError: (error) => error);
  }
}
