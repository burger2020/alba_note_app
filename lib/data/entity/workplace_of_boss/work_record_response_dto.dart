import 'package:albanote_project/data/entity/workplace_of_boss/employee_member_simple_response_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'work_record_response_dto.freezed.dart';

part 'work_record_response_dto.g.dart';

enum WorkType { BEFORE_WORK, WORKING, WORKED, LATE, HOLIDAY, PAID_HOLIDAY, ABSENT }

@freezed
class WorkRecordResponseDTO with _$WorkRecordResponseDTO {
  factory WorkRecordResponseDTO({
    EmployeeMemberSimpleResponseDTO? currentEmployee,
    String? officeGoingTime,
    String? quittingTime,
    WorkType? workType,
  }) = _WorkRecordResponseDTO;

  factory WorkRecordResponseDTO.fromJson(Map<String, dynamic> json) => _$WorkRecordResponseDTOFromJson(json);
}
