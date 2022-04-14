import 'package:albanote_project/data/entity/response_entity.dart';
import 'package:albanote_project/data/repository/config/repository_config.dart';
import 'package:albanote_project/di/model/member/member_type.dart';
import 'package:albanote_project/domain/repository/local/local_shared_preferences.dart';
import 'package:albanote_project/domain/repository/remote/member_repository.dart';
import 'package:dio/dio.dart';

class MemberRepositoryImpl extends MemberRepository {
  MemberRepositoryImpl(this.dio, this.localSP);

  final Dio dio;
  final LocalSharedPreferences localSP;
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
        return ResponseEntity.error(response.data.toString());
      }
    } on DioError catch (e) {
      return ResponseEntity.error(e.message);
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
        return ResponseEntity.error(response.data.toString());
      }
    } on DioError catch (e) {
      return ResponseEntity.error(e.message);
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
        return ResponseEntity.error(response.data.toString());
      }
    } on DioError catch (e) {
      return ResponseEntity.error(e.message);
    }
  }
}
