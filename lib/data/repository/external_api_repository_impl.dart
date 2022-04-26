import 'dart:convert';

import 'package:albanote_project/data/entity/common/response_entity.dart';
import 'package:albanote_project/data/entity/external_api/check_business/check_business_response_dto.dart';
import 'package:albanote_project/domain/repository/local/local_shared_preferences.dart';
import 'package:albanote_project/domain/repository/remote/external_api_repository.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/dio.dart';

/// 외부 api
class ExternalApiRepositoryImpl extends ExternalApiRepository {
  ExternalApiRepositoryImpl(Dio dio, LocalSharedPreferences localSP) : super(dio, localSP);

  /// 사업자 인증
  @override
  Future<ResponseEntity<CheckBusinessResponseDTO>> postCheckBusiness(
    String businessNo,
    String startDate,
    String representativeName,
    String businessName,
    String businessType,
  ) async {
    var url = 'https://api.odcloud.kr/api/nts-businessman/v1/validate';
    try {
      // todo 요청을 간단하게... 사업자만? 사업자, 시작일, 대표자명?
      var body = jsonEncode({
        'businesses': [
          {
            "b_no": businessNo,
            "start_dt": startDate,
            "p_nm": representativeName,
            "b_nm": businessName,
            "b_sector": businessType
          }
        ]
      });
      var response = await dio.post(url,
          queryParameters: {
            'serviceKey': 'f5XOw86YU66YQJl7fewZyPjxPGwjNfGbb+5Ex7YOHGDcW/30XYNzwo4WBMf6ASPCIIoRzx2MChiW1fkEuJBb9A=='
          },
          data: body);
      if (response.statusCode == 200) {
        var result = CheckBusinessResponseDTO.fromJson(response.data as Map<String, dynamic>);
        return ResponseEntity.success(result);
      } else {
        return onErrorHandler(response);
      }
    } on DioError catch (e) {
      return onDioErrorHandler(e);
    }
  }
}

// {
// "businesses": [
// {
// "b_no": "7602601038",
// "start_dt": "20200608",
// "p_nm": "대표자명",
// "p_nm2": "",
// "b_nm": "",
// "corp_no": "",
// "b_sector": "",
// "b_type": ""
// }
// ]
// }
