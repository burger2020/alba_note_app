import 'package:albanote_project/data/entity/external_api/check_business/check_business_request_param_response_dto.dart';
import 'package:albanote_project/data/entity/external_api/check_business/check_business_status_response_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_business_data_response_dto.freezed.dart';

part 'check_business_data_response_dto.g.dart';

/// 사업자 확인 결과 데이터 응답 DTO
@freezed
class CheckBusinessDataResponseDTO with _$CheckBusinessDataResponseDTO {
    factory CheckBusinessDataResponseDTO({
        String? b_no,
        String? valid,
        CheckBusinessRequestParamResponseDTO? request_param,
        CheckBusinessStatusResponseDTO? status
    }) = _CheckBusinessDataResponseDTO;

    factory CheckBusinessDataResponseDTO.fromJson(Map<String, dynamic> json) => _$CheckBusinessDataResponseDTOFromJson(json);
}

