import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_employee_response_dto.freezed.dart';

part 'current_employee_response_dto.g.dart';

/// 현재 근무자 조회 DTO
@freezed
class CurrentEmployeeResponseDTO with _$CurrentEmployeeResponseDTO {
  factory CurrentEmployeeResponseDTO({
    int? memberId,
    String? name,
    String? imageUrl,
    String? rankName,
    int? officeGoingTime,
  }) = _CurrentEmployeeResponseDTO;

  factory CurrentEmployeeResponseDTO.fromJson(Map<String, dynamic> json) => _$CurrentEmployeeResponseDTOFromJson(json);
}
