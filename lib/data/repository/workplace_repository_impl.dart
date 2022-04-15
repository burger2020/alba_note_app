import 'dart:convert';

import 'package:albanote_project/data/entity/common/response_entity.dart';
import 'package:albanote_project/data/entity/workplace_of_boss/workplace_info_of_boss_response_dto.dart';
import 'package:albanote_project/data/repository/config/repository_config.dart';
import 'package:albanote_project/domain/repository/local/local_shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

import '../../domain/repository/remote/workplace_repository.dart';

class WorkplaceOfBossRepositoryImpl extends WorkplaceOfBossRepository {
  WorkplaceOfBossRepositoryImpl(Dio dio, LocalSharedPreferences localSP) : super(dio, localSP);

  static const _baseUri = RepositoryConfig.serverUrl + '/workplace';

  @override
  Future<ResponseEntity<WorkplaceInfoOfBossResponseDTO>> getWorkplaceInfo(int memberId, int? workplaceId) async {
    const uri = _baseUri + '/memberLogout';
    try {
      var accessToken = await localSP.accessToken;
      var memberId = await localSP.memberId;
      var response = await dio.put(uri,
          data: {'memberId': memberId, 'workplaceId': workplaceId},
          options: Options(headers: {'Authorization': accessToken}));
      if (response.statusCode == HttpStatus.ok) {
        var result = WorkplaceInfoOfBossResponseDTO.fromJson(jsonDecode(response.data));
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
}
