import 'package:albanote_project/data/entity/workplace_of_boss/completed_todo_response_dto.dart';
import 'package:albanote_project/data/entity/workplace_of_boss/current_employee_response_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'workplace_info_of_boss_response_dto.freezed.dart';
part 'workplace_info_of_boss_response_dto.g.dart';

/// 사장의 대표 일터 정보 조회 DTO
@freezed
class WorkplaceInfoOfBossResponseDTO with _$WorkplaceInfoOfBossResponseDTO {
  factory WorkplaceInfoOfBossResponseDTO({
    int? workplaceId,
    int? workplaceTitle,
    List<CurrentEmployeeResponseDTO>? currentEmployees,
    List<CompletedTodoResponseDTO>? completedTodos,
    int? totalTodoCount,
  }) = _WorkplaceInfoOfBossResponseDTO;

  factory WorkplaceInfoOfBossResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$WorkplaceInfoOfBossResponseDTOFromJson(json);
}