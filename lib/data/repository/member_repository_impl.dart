import 'package:albanote_project/config/repository_config.dart';
import 'package:albanote_project/data/entity/common/response_entity.dart';
import 'package:albanote_project/data/repository/base_repository.dart';
import 'package:albanote_project/di/model/member/member_type.dart';
import 'package:albanote_project/domain/repository/local/local_shared_preferences.dart';
import 'package:albanote_project/domain/repository/remote/member_repository.dart';
import 'package:dio/dio.dart';

class MemberRepositoryImpl extends MemberRepository {
  MemberRepositoryImpl(Dio dio, LocalSharedPreferences localSP) : super(dio, localSP);

  static const _baseUri = RepositoryConfig.serverUrl + '/member';

  /// fcmToken 업데이트
  @override
  Future<ResponseEntity<bool>> putMemberFcmToken(String fcmToken) async {
    const uri = _baseUri + '/fcmToken';
    var accessToken = await localSP.accessToken;
    var memberId = await localSP.memberId;

    return request<bool, bool>(
      uri: uri,
      method: HttpMethod.PUT,
      body: {'memberId': memberId, 'body': fcmToken},
      authorization: accessToken,
      onSuccess: (data) => successDTO(data),
      onError: (error) => error,
    );
  }

  /// 멤버 타입 선택
  @override
  Future<ResponseEntity<bool>> putSelectMemberType(MemberType memberType) async {
    const uri = _baseUri + '/selectMemberType';
    var accessToken = await localSP.accessToken;
    var memberId = await localSP.memberId;

    return request<bool, bool>(
      uri: uri,
      method: HttpMethod.PUT,
      body: {'memberId': memberId, 'body': memberType.name},
      authorization: accessToken,
      onSuccess: (data) => successDTO(data),
      onError: (error) => error,
    );
  }

  /// 멤버 로그아웃
  @override
  Future<ResponseEntity<bool>> postMemberLogout() async {
    const uri = _baseUri + '/memberLogout';
    var accessToken = await localSP.accessToken;
    var memberId = await localSP.memberId;

    return request<bool, bool>(
      uri: uri,
      method: HttpMethod.POST,
      body: {'memberId': memberId},
      authorization: accessToken,
      onSuccess: (data) => successDTO(data),
      onError: (error) => error,
    );
  }
}
