import 'dart:convert';

import 'package:albanote_project/data/entity/common/response_entity.dart';
import 'package:albanote_project/data/entity/external_api/check_business/check_business_response_dto.dart';
import 'package:albanote_project/data/repository/base_repository.dart';
import 'package:albanote_project/domain/repository/local/local_shared_preferences.dart';
import 'package:albanote_project/domain/repository/remote/external_api_repository.dart';
import 'package:dio/dio.dart';

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
    var serviceKey = 'f5XOw86YU66YQJl7fewZyPjxPGwjNfGbb+5Ex7YOHGDcW/30XYNzwo4WBMf6ASPCIIoRzx2MChiW1fkEuJBb9A==';

    return request<Map<String, dynamic>, CheckBusinessResponseDTO>(
      uri: url,
      method: HttpMethod.POST,
      queryParameter: {'serviceKey': serviceKey},
      body: jsonEncode({
        'businesses': [
          {
            "b_no": businessNo,
            "start_dt": startDate,
            "p_nm": representativeName,
            "b_nm": businessName,
            "b_sector": businessType
          }
        ]
      }),
      onSuccess: (data) => successDTO(CheckBusinessResponseDTO.fromJson(Map<String, dynamic>.from(data))),
      onError: (error) => error,
    );
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
