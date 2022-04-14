import 'package:albanote_project/data/entity/common/response_entity.dart';
import 'package:albanote_project/domain/repository/common_repository.dart';
import 'package:albanote_project/domain/repository/local/local_shared_preferences.dart';
import 'package:dio/dio.dart';

import '../repository_config.dart';

class CommonRepositoryImpl extends CommonRepository {
  CommonRepositoryImpl(this.dio, this.localSP);

  final Dio dio;
  final LocalSharedPreferences localSP;

  @override
  Future<ResponseEntity<bool>> postCheckAccessTokenValid() async {
    const uri = '/checkValidAccessToken';
    try {
      var accessToken = await localSP.findMemberAccessToken();
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
}
