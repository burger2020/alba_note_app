import 'package:freezed_annotation/freezed_annotation.dart';

part 'completed_todo_response_dto.freezed.dart';

part 'completed_todo_response_dto.g.dart';

/// 완료된 할일 조회 DTO
@freezed
class CompletedTodoResponseDTO with _$CompletedTodoResponseDTO {
    factory CompletedTodoResponseDTO({
      int? todoRecordId,
      String? todoTitle,
      int? completedTime
    }) = _CompletedTodoResponseDTO;

    factory CompletedTodoResponseDTO.fromJson(Map<String, dynamic> json) => _$CompletedTodoResponseDTOFromJson(json);
}