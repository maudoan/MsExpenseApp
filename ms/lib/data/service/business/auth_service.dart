import 'package:dio/dio.dart';
import 'package:ms/core/base/base_response.dart';
import 'package:ms/core/network/api_helper.dart';
import 'package:ms/data/model/login_param.dart';
import 'package:ms/data/model/user.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  static AuthService create() {
    final dio = ApiHelper().createDio()..addAuthInterceptors();

    final client = AuthService(dio);
    return client;
  }

  @POST('http://192.168.0.7:8081/api/users/register')
  Future<HttpResponse<BaseResponse<User>>> register(
      @Body() Map<String, dynamic> map);

  @POST('http://192.168.0.7:8081/api/auth/login')
  Future<HttpResponse<BaseResponse<User>>> login(
      @Body() LoginParam? loginParam);
}
