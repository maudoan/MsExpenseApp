
import 'package:ms/data/model/login_param.dart';
import 'package:ms/data/model/user.dart';
import 'package:ms/data/service/business/service.dart';
import 'package:ms/data/source/business/ms_repositoy.dart';

class ServiceApi implements MsRepository {
  final MsService msService;

  ServiceApi({required this.msService});
  
  @override
  Future<User?> getCurrentUser() {
    final response = msService.getCurrentUser().then(
      (httpResponse) {
        return httpResponse.data.data;
      },
    );
    return response;
  }
  
  @override
  Future login(LoginParam param) {
    final response = msService.login(param).then(
      (httpResponse) {
        return httpResponse.data.data;
      },
    );
    return response;
  }
  
}