import 'package:ms/data/model/login_param.dart';
import 'package:ms/data/model/user.dart';
import 'package:ms/data/source/business/ms_repositoy.dart';

class MsRepositoryImpl implements MsRepository {
  const MsRepositoryImpl({required this.api});
  final MsRepository api;
  @override
  Future<User> getCurrentUser() {
    throw UnimplementedError();
  }
  
  @override
  Future login(LoginParam param) {
    throw UnimplementedError();
  }
  
}