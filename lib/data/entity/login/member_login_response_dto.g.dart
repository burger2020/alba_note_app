// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_login_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MemberLoginResponseDTO _$$_MemberLoginResponseDTOFromJson(
        Map<String, dynamic> json) =>
    _$_MemberLoginResponseDTO(
      id: json['id'] as int?,
      socialId: json['socialId'] as String?,
      socialLoginType: json['socialLoginType'] as String?,
      osType: json['osType'] as String?,
      memberType: json['memberType'] as String?,
      memberTokenInfo: json['memberTokenInfo'] == null
          ? null
          : MemberTokenInfoDTO.fromJson(
              json['memberTokenInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_MemberLoginResponseDTOToJson(
        _$_MemberLoginResponseDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'socialId': instance.socialId,
      'socialLoginType': instance.socialLoginType,
      'osType': instance.osType,
      'memberType': instance.memberType,
      'memberTokenInfo': instance.memberTokenInfo,
    };
