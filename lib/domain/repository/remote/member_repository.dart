import 'package:albanote_project/data/entity/response_entity.dart';
import 'package:albanote_project/di/model/member/member_type.dart';

abstract class MemberRepository {
  /// fcmToken 업데이트
  Future<ResponseEntity<bool>> putMemberFcmToken(String fcmToken);

  /// 멤버 타입 선택
  Future<ResponseEntity<bool>> putSelectMemberType(MemberType memberType);

  /// 멤버 로그아웃
  Future<ResponseEntity<bool>> postMemberLogout();
}
