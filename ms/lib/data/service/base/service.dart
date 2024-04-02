import 'package:dio/dio.dart';
import 'package:ms/core/base/base_response.dart';
import 'package:ms/core/network/api_helper.dart';
import 'package:ms/data/model/user.dart';
import 'package:retrofit/retrofit.dart';

part 'service.g.dart';
@RestApi()
abstract class MsService {
  factory MsService(Dio dio, {String baseUrl}) = _MsService;

  static MsService create() {
    final dio = ApiHelper().createDio()..addInterceptors();

    final client = MsService(dio);
    return client;
  }
  
  @GET('http://10.2.9.149:8081/api/users/current')
  Future<HttpResponse<BaseResponse<User>>> getCurrentUser();
}
