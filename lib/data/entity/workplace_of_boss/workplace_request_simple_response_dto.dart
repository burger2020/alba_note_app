import 'package:albanote_project/data/entity/workplace_of_boss/employee_member_simple_response_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'workplace_request_simple_response_dto.freezed.dart';

part 'workplace_request_simple_response_dto.g.dart';

enum WorkplaceRequestType {
  @JsonValue("COMMUTE_REGISTRATION")
  COMMUTE_REGISTRATION,
  @JsonValue("COMMUTE_CORRECTION")
  COMMUTE_CORRECTION
}

extension WorkplaceRequestTypeExtension on WorkplaceRequestType {
  String getRequestTypeText() {
    switch (this) {
      case WorkplaceRequestType.COMMUTE_REGISTRATION:
        return "근무 등록 요청";
      case WorkplaceRequestType.COMMUTE_CORRECTION:
        return '출퇴근 정정 요청';
    }
  }
}

@freezed
class WorkplaceRequestSimpleResponseDTO with _$WorkplaceRequestSimpleResponseDTO {
  factory WorkplaceRequestSimpleResponseDTO(
      {int? requestId,
      String? createdDate,
      WorkplaceRequestType? requestType, //WorkplaceRequestType
      bool? isCompleted,
      EmployeeMemberSimpleResponseDTO? requestMember}) = _WorkplaceRequestSimpleResponseDTO;

  factory WorkplaceRequestSimpleResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$WorkplaceRequestSimpleResponseDTOFromJson(json);
}

extension WorkplaceRequestSimpleResponseDTOExtension on WorkplaceRequestSimpleResponseDTO {
  // 요청 상태에 따른 문자
  String getCompleteStatusText() {
    return isCompleted == null
        ? '요청 대기'
        : isCompleted!
            ? '수락됨'
            : '거절됨';
  }
}
