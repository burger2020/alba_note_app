import 'dart:convert';

import 'package:albanote_project/data/entity/common/error_dto.dart';
import 'package:albanote_project/data/entity/common/response_entity.dart';
import 'package:albanote_project/domain/repository/local/local_shared_preferences.dart';
import 'package:dio/dio.dart';

class BaseRepository {
  BaseRepository(this.dio, this.localSP);

  final Dio dio;
  final LocalSharedPreferences localSP;

  Future<ResponseEntity<T>> onErrorHandler<T>(Response response) async {
    var errorDTO = ErrorDTO.fromJson(jsonDecode(response.data));
    if (errorDTO.code == 600) {}

    return ResponseEntity.error(errorDTO);
  }

  Future<ResponseEntity<T>> onDioErrorHandler<T>(DioError e) async {
    return ResponseEntity.error(ErrorDTO(message: e.message, code: e.response!.statusCode));
  }
}
