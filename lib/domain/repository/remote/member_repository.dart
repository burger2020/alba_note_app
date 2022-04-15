import 'package:albanote_project/data/entity/common/response_entity.dart';
import 'package:albanote_project/data/repository/base_repository.dart';
import 'package:albanote_project/di/model/member/member_type.dart';
import 'package:albanote_project/domain/repository/local/local_shared_preferences.dart';
import 'package:dio/dio.dart';

abstract class MemberRepository extends BaseRepository {
  MemberRepository(Dio dio, LocalSharedPreferences localSP) : super(dio, localSP);

  /// fcmToken 업데이트
  Future<ResponseEntity<bool>> putMemberFcmToken(String fcmToken);

  /// 멤버 타입 선택
  Future<ResponseEntity<bool>> putSelectMemberType(MemberType memberType);

  /// 멤버 로그아웃
  Future<ResponseEntity<bool>> postMemberLogout();
}
