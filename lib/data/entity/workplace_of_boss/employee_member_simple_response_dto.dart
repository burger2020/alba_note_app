import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee_member_simple_response_dto.freezed.dart';

part 'employee_member_simple_response_dto.g.dart';

@freezed
class EmployeeMemberSimpleResponseDTO with _$EmployeeMemberSimpleResponseDTO {
    factory EmployeeMemberSimpleResponseDTO({
      int? memberId,
      int? employeeId,
      String? name,
      String? imageUrl,
      String? rankName
    }) = _EmployeeMemberSimpleResponseDTO;

    factory EmployeeMemberSimpleResponseDTO.fromJson(Map<String, dynamic> json) => _$EmployeeMemberSimpleResponseDTOFromJson(json);
}