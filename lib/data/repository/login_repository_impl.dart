import 'package:albanote_project/domain/repository/login_repository.dart';
import 'package:http/http.dart' as http;

class LoginRepositoryImpl extends LoginRepository {
  LoginRepositoryImpl(this.client);

  final http.Client client;
}
