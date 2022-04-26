import 'package:freezed_annotation/freezed_annotation.dart';

import 'member_token_info_dto.dart';

part 'member_login_response_dto.freezed.dart';
part 'member_login_response_dto.g.dart';

@freezed
class MemberLoginResponseDTO with _$MemberLoginResponseDTO {
  factory MemberLoginResponseDTO(
      {int? id,
      String? socialId,
      String? socialLoginType,
      String? osType,
      String? memberType,
      MemberTokenInfoDTO? memberTokenInfo}) = _MemberLoginResponseDTO;

  factory MemberLoginResponseDTO.fromJson(Map<String, dynamic> json) => _$MemberLoginResponseDTOFromJson(json);
}
