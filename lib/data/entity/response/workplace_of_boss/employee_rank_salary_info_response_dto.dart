import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee_rank_salary_info_response_dto.freezed.dart';

part 'employee_rank_salary_info_response_dto.g.dart';

/// 직원 직급 급여 정보 조회 DTO
@freezed
class EmployeeRankSalaryInfoResponseDTO with _$EmployeeRankSalaryInfoResponseDTO {
  factory EmployeeRankSalaryInfoResponseDTO({
    int? rankId,
    int? ordinaryHourlyWage,
    int? hourlyWageCalculationUnit,
    String? breakEndTime,
    String? breakStartTime,
    String? paidHoliday,
    bool? isCommuteTimeVaryByDayOfWeek,
    bool? isNightAllowance,
    double? nightAllowanceExtraMultiples,
    bool? isOvertimeAllowance,
    double? overtimeAllowanceExtraMultiples,
    bool? isHolidayAllowance,
    double? holidayAllowanceExtraMultiples,
  }) = _EmployeeRankSalaryInfoResponseDTO;

  factory EmployeeRankSalaryInfoResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$EmployeeRankSalaryInfoResponseDTOFromJson(json);
}
