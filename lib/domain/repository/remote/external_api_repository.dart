import 'package:albanote_project/data/entity/common/response_entity.dart';
import 'package:albanote_project/data/entity/external_api/check_business/check_business_response_dto.dart';
import 'package:albanote_project/data/repository/base_repository.dart';
import 'package:albanote_project/domain/repository/local/local_shared_preferences.dart';
import 'package:dio/src/dio.dart';

abstract class ExternalApiRepository extends BaseRepository {
  ExternalApiRepository(Dio dio, LocalSharedPreferences localSP) : super(dio, localSP);

  /// 사업자 인증
  Future<ResponseEntity<CheckBusinessResponseDTO>> postCheckBusiness(
      String businessNo, String startDate, String representativeName, String businessName, String businessType);

  //
}
