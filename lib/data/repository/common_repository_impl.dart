import 'dart:convert';

import 'package:albanote_project/data/entity/common/response_entity.dart';
import 'package:albanote_project/data/entity/login/member_token_info_dto.dart';
import 'package:albanote_project/domain/repository/remote/common_repository.dart';
import 'package:albanote_project/domain/repository/local/local_shared_preferences.dart';
import 'package:dio/dio.dart';

import 'config/repository_config.dart';

class CommonRepositoryImpl extends CommonRepository {
  CommonRepositoryImpl(Dio dio, LocalSharedPreferences localSP) : super(dio, localSP);

  @override
  Future<ResponseEntity<bool>> postCheckAccessTokenValid() async {
    const uri = '/common/checkValidAccessToken';
    try {
      var accessToken = await localSP.accessToken;
      var response = await dio.post(
        RepositoryConfig.serverUrl + uri,
        options: Options(headers: {'Authorization': accessToken}),
      );
      if (response.statusCode == 200) {
        var result = response.data as bool;
        return ResponseEntity.success(result);
      } else {
        return onErrorHandler(response);
      }
    } on DioError catch (e) {
      return onDioErrorHandler(e);
    }
  }

  @override
  Future<ResponseEntity<MemberTokenInfoDTO>> postRefreshToken() async {
    const uri = '/common/refreshToken';
    try {
      final memberId = await localSP.memberId;
      var response = await dio.post(
        RepositoryConfig.serverUrl + uri,
        data: {'memberId': memberId},
        options: Options(headers: {'Authorization': await localSP.accessToken}),
      );

      /// if 부분 전체 다 상위 클래스에서 처리하면 될듯 ㅇㅇ
      if (response.statusCode == 200) {
        var result = MemberTokenInfoDTO.fromJson(jsonDecode(response.data));
        return ResponseEntity.success(result);
      } else {
        return onErrorHandler(response);
      }
    } on DioError catch (e) {
      return onDioErrorHandler(e);
    }
  }
}
