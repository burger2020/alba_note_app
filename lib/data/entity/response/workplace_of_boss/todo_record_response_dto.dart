import 'package:albanote_project/data/entity/response/workplace_of_boss/employee_member_simple_response_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'todo_record_response_dto.freezed.dart';

part 'todo_record_response_dto.g.dart';

@freezed
class TodoRecordResponseDTO with _$TodoRecordResponseDTO {
  factory TodoRecordResponseDTO({
    int? todoRecordId,
    int? todoId,
    String? todoTitle,
    String? completedTime,
    String? completedDate,
    EmployeeMemberSimpleResponseDTO? completedMember,
  }) = _TodoRecordResponseDTO;

  factory TodoRecordResponseDTO.fromJson(Map<String, dynamic> json) => _$TodoRecordResponseDTOFromJson(json);
}
