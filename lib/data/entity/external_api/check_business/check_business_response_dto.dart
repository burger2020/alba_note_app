import 'package:albanote_project/data/entity/external_api/check_business/check_business_data_response_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_business_response_dto.freezed.dart';

part 'check_business_response_dto.g.dart';

/// 사업자 확인 결과 응답 DTO
@freezed
class CheckBusinessResponseDTO with _$CheckBusinessResponseDTO {
  factory CheckBusinessResponseDTO({
    int? request_cnt,
    int? valid_cnt,
    String? status_code,
    List<CheckBusinessDataResponseDTO>? data
  }) = _CheckBusinessResponseDTO;

  factory CheckBusinessResponseDTO.fromJson(Map<String, dynamic> json) => _$CheckBusinessResponseDTOFromJson(json);
}

// "data": [
// {
// "b_no": "7602601038",
// "valid": "01",
// "request_param": {},
// "status": {}
// }
// ]