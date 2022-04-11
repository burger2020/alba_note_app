import 'package:albanote_project/data/repository/repository_config.dart';
import 'package:albanote_project/domain/repository/login/login_repository.dart';
import 'package:dio/dio.dart';
import '../../entity/response_entity.dart';

class LoginRepositoryImpl extends LoginRepository {
  var dio = Dio();

  @override
  Future<ResponseEntity<bool>> postLogin(String idToken, String accessToken) async {
    try {
      var response = await dio.get(RepositoryConfig.serverUrl);
      print('response.extra = ${response.statusCode}');
      print('response.extra = ${response.data}');
      print('response.extra = ${response.extra}');
      if (response.statusCode == 200) {
        response.data; //data convert
        return const ResponseEntity.success(true);
      } else {
        return ResponseEntity.error(response.data.toString());
      }
    } catch (e) {
      return const ResponseEntity.success(false);
    }
  }
}
