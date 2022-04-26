import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_business_request_param_response_dto.freezed.dart';

part 'check_business_request_param_response_dto.g.dart';

/// 사업자 확인 요청 파라미터 응답 DTO
@freezed
class CheckBusinessRequestParamResponseDTO with _$CheckBusinessRequestParamResponseDTO {
  factory CheckBusinessRequestParamResponseDTO(
      {String? b_no,
      String? start_dt,
      String? p_nm,
      String? b_nm,
      String? corp_no,
      String? b_type,
      String? b_sector}) = _CheckBusinessRequestParamResponseDTO;

  factory CheckBusinessRequestParamResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$CheckBusinessRequestParamResponseDTOFromJson(json);
}

// "b_no": "7602601038",
// "start_dt": "20200608",
// "p_nm": "박교열",
// "p_nm2": "",
// "b_nm": "",
// "corp_no": "",
// "b_type": "",
// "b_sector": ""
