import 'package:ms/data/model/login_param.dart';
import 'package:ms/data/model/user.dart';

abstract class MsRepository {
  Future<User?> getCurrentUser();
  Future<dynamic> login(LoginParam param);
}