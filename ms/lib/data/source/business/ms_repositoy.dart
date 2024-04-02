import 'package:ms/data/model/user.dart';

abstract class MsRepository {
  Future<User?> getCurrentUser();
}