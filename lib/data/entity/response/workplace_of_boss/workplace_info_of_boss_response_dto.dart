import 'package:freezed_annotation/freezed_annotation.dart';

import 'todo_record_response_dto.dart';
import 'work_record_response_dto.dart';
import 'workplace_request_simple_response_dto.dart';

part 'workplace_info_of_boss_response_dto.freezed.dart';

part 'workplace_info_of_boss_response_dto.g.dart';

/// 사장의 대표 일터 정보 조회 DTO
@freezed
class WorkplaceInfoOfBossResponseDTO with _$WorkplaceInfoOfBossResponseDTO {
  factory WorkplaceInfoOfBossResponseDTO({
    int? workplaceId,
    String? workplaceTitle,
    String? workplaceImageUrl,
    List<WorkRecordResponseDTO>? currentEmployees,
    List<TodoRecordResponseDTO>? completedTodos,
    List<WorkplaceRequestSimpleResponseDTO>? workplaceRequest,
    int? totalTodoCount,
    @Default(0) int? totalEmployeeCount,
  }) = _WorkplaceInfoOfBossResponseDTO;

  factory WorkplaceInfoOfBossResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$WorkplaceInfoOfBossResponseDTOFromJson(json);
}