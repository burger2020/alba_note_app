import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_business_status_response_dto.freezed.dart';

part 'check_business_status_response_dto.g.dart';

/// 사업자 확인 결과 상태 응답 DTO
@freezed
class CheckBusinessStatusResponseDTO with _$CheckBusinessStatusResponseDTO {
  factory CheckBusinessStatusResponseDTO(
      {String? b_no,
      String? b_stt,
      String? b_stt_cd,
      String? tax_type,
      String? tab_type_cd,
      String? end_dt,
      String? utcc_yn,
      String? tax_type_change_dt}) = _CheckBusinessStatusResponseDTO;

  factory CheckBusinessStatusResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$CheckBusinessStatusResponseDTOFromJson(json);
}

// "b_no": "7602601038",
// "b_stt": "폐업자",
// "b_stt_cd": "03",
// "tax_type": "부가가치세 일반과세자",
// "tax_type_cd": "01",
// "end_dt": "20210430",
// "utcc_yn": "N",
// "tax_type_change_dt": ""
