import 'package:albanote_project/config/repository_config.dart';
import 'package:albanote_project/data/entity/common/response_entity.dart';
import 'package:albanote_project/data/entity/login/member_token_info_dto.dart';
import 'package:albanote_project/data/repository/base_repository.dart';
import 'package:albanote_project/domain/repository/local/local_shared_preferences.dart';
import 'package:albanote_project/domain/repository/remote/common_repository.dart';
import 'package:dio/dio.dart';

class CommonRepositoryImpl extends CommonRepository {
  CommonRepositoryImpl(Dio dio, LocalSharedPreferences localSP) : super(dio, localSP);

  @override
  Future<ResponseEntity<String>> getCurrentServerTime() async {
    const uri = RepositoryConfig.serverUrl + '/common/currentTime';
    var accessToken = await localSP.accessToken;

    return request<String, String>(
      uri: uri,
      method: HttpMethod.GET,
      authorization: accessToken,
      onSuccess: (data) => successDTO(data),
      onError: (e) => e,
    );
  }

  @override
  Future<ResponseEntity<bool>> postCheckAccessTokenValid() async {
    const uri = RepositoryConfig.serverUrl + '/common/checkValidAccessToken';
    var accessToken = await localSP.accessToken;

    return request<bool, bool>(
      uri: uri,
      method: HttpMethod.POST,
      authorization: accessToken,
      onSuccess: (data) => successDTO(data),
      onError: (error) => error,
    );
  }
}
