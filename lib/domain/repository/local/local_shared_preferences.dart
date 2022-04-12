import 'dart:convert';

import 'package:albanote_project/data/entity/login/member_login_response_dto.dart';
import 'package:albanote_project/data/entity/login/member_token_info_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalSharedPreferences {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  static const _memberInfoKey = '_memberInfoKey';

  Future<String?> findMemberAccessToken() async {
    var memberInfo = await findMemberInfo();
    if (memberInfo?.memberTokenInfo?.accessToken != null) {
      return "Barer " + memberInfo!.memberTokenInfo!.accessToken.toString();
    } else {
      return '';
    }
  }

  /// 멤버 정보 저장
  void updateMemberInfo(MemberLoginResponseDTO memberInfo) async {
    var pref = await _pref;
    pref.setString(_memberInfoKey, jsonEncode(memberInfo));
  }

  /// 멤버 정보 조회
  Future<MemberLoginResponseDTO?> findMemberInfo() async {
    var pref = await _pref;
    var json = pref.getString(_memberInfoKey);
    if (json == null) return null;
    return MemberLoginResponseDTO.fromJson(jsonDecode(json));
  }

  /// 로그아웃 상태로 -> 앱 pref 정보 전체 삭제
  Future setLogoutState() async {
    var pref = await _pref;
    pref.clear();
  }
}
