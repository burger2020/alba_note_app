import 'package:albanote_project/domain/model/coordinate_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_workplace_request_dto.freezed.dart';

part 'create_workplace_request_dto.g.dart';

@freezed
class CreateWorkplaceRequestDTO with _$CreateWorkplaceRequestDTO {
  factory CreateWorkplaceRequestDTO(
      {int? bossMemberId,
      String? name,
      String? address,
      String? detailAddress,
      CoordinateModel? commuteRecordCoordinate,
      int? commuteRecordRadius,
      String? bossEmployeeRankName,
      String? bossEmployeeName,
      String? bossEmployeePhoneNumber}) = _CreateWorkplaceRequestDTO;

  factory CreateWorkplaceRequestDTO.fromJson(Map<String, dynamic> json) => _$CreateWorkplaceRequestDTOFromJson(json);
}
