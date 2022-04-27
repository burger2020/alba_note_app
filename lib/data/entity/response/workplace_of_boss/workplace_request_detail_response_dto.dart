import 'package:albanote_project/data/entity/response/workplace_of_boss/employee_member_simple_response_dto.dart';
import 'package:albanote_project/data/entity/response/workplace_of_boss/workplace_request_simple_response_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'workplace_request_detail_response_dto.freezed.dart';

part 'workplace_request_detail_response_dto.g.dart';

@freezed
class WorkplaceRequestDetailResponseDTO with _$WorkplaceRequestDetailResponseDTO {
  factory WorkplaceRequestDetailResponseDTO({
    int? requestId,
    String? createdDate,
    WorkplaceRequestType? requestType,
    String? requestContent,
    bool? isComplete,
    String? memo,
    EmployeeMemberSimpleResponseDTO? requestMember,
    String? requestMemo,
    String? requestWorkDate,
    String? requestOfficeGoingTime,
    String? requestQuittingTime,
    String? existingOfficeGoingTime,
    String? existingQuittingTime,
  }) = _WorkplaceRequestDetailResponseDTO;

  factory WorkplaceRequestDetailResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$WorkplaceRequestDetailResponseDTOFromJson(json);
}
