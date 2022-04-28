import 'package:albanote_project/data/entity/response/workplace_of_boss/employee_member_simple_response_dto.dart';
import 'package:albanote_project/data/entity/response/workplace_of_boss/employee_rank_salary_info_response_dto.dart';
import 'package:albanote_project/data/entity/response/workplace_of_boss/workplace_request_simple_response_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'workplace_request_detail_response_dto.freezed.dart';

part 'workplace_request_detail_response_dto.g.dart';

@freezed
class WorkplaceRequestDetailResponseDTO with _$WorkplaceRequestDetailResponseDTO {
  factory WorkplaceRequestDetailResponseDTO({
    int? requestId,
    String? createdDate,
    EmployeeMemberSimpleResponseDTO? requestMember,
    WorkplaceRequestType? requestType,
    String? requestContent,
    bool? isComplete,
    String? memo,
    String? requestMemo,
    String? requestWorkDate,

    String? requestOfficeGoingTime,
    String? requestQuittingTime,
    String? requestBreakTime,
    String? requestNightBreakTime,
    int? requestTotalSalary,

    String? existingOfficeGoingTime,
    String? existingQuittingTime,
    String? existingBreakTime,
    String? existingNightBreakTime,
    int? existingTotalSalary,

    EmployeeRankSalaryInfoResponseDTO? employeeRankInfo,
  }) = _WorkplaceRequestDetailResponseDTO;

  factory WorkplaceRequestDetailResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$WorkplaceRequestDetailResponseDTOFromJson(json);
}
