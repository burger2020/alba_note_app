import 'dart:convert';
import 'dart:io';

import 'package:albanote_project/config/repository_config.dart';
import 'package:albanote_project/data/entity/common/response_entity.dart';
import 'package:albanote_project/data/entity/login/member_login_response_dto.dart';
import 'package:albanote_project/data/repository/base_repository.dart';
import 'package:albanote_project/di/model/member/os_type.dart';
import 'package:albanote_project/domain/repository/local/local_shared_preferences.dart';
import 'package:albanote_project/domain/repository/remote/login_repository.dart';
import 'package:dio/dio.dart';

import '../../di/model/member/social_login_type.dart';

class LoginRepositoryImpl extends LoginRepository {
  LoginRepositoryImpl(Dio dio, LocalSharedPreferences localSP) : super(dio, localSP);

  /// 로그인 및 회원가입
  @override
  Future<ResponseEntity<MemberLoginResponseDTO>> postLogin(
      String idToken, String accessToken, SocialLoginType socialLoginType) async {
    const uri = RepositoryConfig.serverUrl + '/login';

    return request<Map<String, dynamic>, MemberLoginResponseDTO>(
      uri: uri,
      method: HttpMethod.POST,
      body: {
        'socialId': idToken,
        'socialLoginType': socialLoginType.name,
        'osType': Platform.isAndroid ? OsType.ANDROID.name : OsType.IOS.name,
      },
      authorization: RepositoryConfig.basicToken,
      onSuccess: (data) => successDTO(MemberLoginResponseDTO.fromJson(Map<String, dynamic>.from(data))),
      onError: (error) => error,
    );
  }
}
