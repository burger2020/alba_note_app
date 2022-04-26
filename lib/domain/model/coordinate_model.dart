import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coordinate_model.freezed.dart';

part 'coordinate_model.g.dart';

@freezed
class CoordinateModel with _$CoordinateModel {
  factory CoordinateModel({
    double? lat,
    double? lng
  }) = _CoordinateModel;

  factory CoordinateModel.fromJson(Map<String, dynamic> json) => _$CoordinateModelFromJson(json);
}
