import 'package:ms/data/model/login_param.dart';

abstract class AuthRepository {
  Future<dynamic> login(LoginParam param);
}