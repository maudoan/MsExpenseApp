import 'package:ms/data/model/login_param.dart';
import 'package:ms/data/service/business/auth_repository.dart';
import 'package:ms/data/service/business/auth_service.dart';

class AuthServiceApi implements AuthRepository {
  final AuthService authService;

  AuthServiceApi({required this.authService});

  @override
  Future login(LoginParam param) {
    final response = authService.login(param).then(
      (httpResponse) {
        return httpResponse.response.data;
      },
    );
    return response;
  }
}
