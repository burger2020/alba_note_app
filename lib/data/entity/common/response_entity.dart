import 'package:albanote_project/data/entity/common/error_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'response_entity.freezed.dart';

@freezed
abstract class ResponseEntity<T> with _$ResponseEntity<T> {
    const factory ResponseEntity.success(T data) = Success;
    const factory ResponseEntity.error(ErrorDTO e) = Error;
}