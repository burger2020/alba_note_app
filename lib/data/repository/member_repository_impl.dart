import 'package:albanote_project/config/repository_config.dart';
import 'package:albanote_project/data/entity/common/response_entity.dart';
import 'package:albanote_project/di/model/member/member_type.dart';
import 'package:albanote_project/domain/repository/local/local_shared_preferences.dart';
import 'package:albanote_project/domain/repository/remote/member_repository.dart';
import 'package:dio/dio.dart';

class MemberRepositoryImpl extends MemberRepository {
  MemberRepositoryImpl(Dio dio, LocalSharedPreferences localSP) : super(dio, localSP);

  static const _baseUri = RepositoryConfig.serverUrl + '/member';

  @override
  Future<ResponseEntity<bool>> putMemberFcmToken(String fcmToken) async {
    const uri = _baseUri + '/fcmToken';
    try {
      var accessToken = await localSP.accessToken;
      var memberId = await localSP.memberId;
      var response = await dio.put(uri,
          data: {
            'memberId': memberId,
            'body': fcmToken,
          },
          options: Options(headers: {'Authorization': accessToken}));

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
  Future<ResponseEntity<bool>> putSelectMemberType(MemberType memberType) async {
    const uri = _baseUri + '/selectMemberType';
    try {
      var accessToken = await localSP.accessToken;
      var memberId = await localSP.memberId;
      var response = await dio.put(uri,
          data: {
            'memberId': memberId,
            'body': memberType.name,
          },
          options: Options(headers: {'Authorization': accessToken}));
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
  Future<ResponseEntity<bool>> postMemberLogout() async {
    const uri = _baseUri + '/memberLogout';
    try {
      var accessToken = await localSP.accessToken;
      var memberId = await localSP.memberId;
      var response = await dio.put(
        uri,
        data: {'memberId': memberId},
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
