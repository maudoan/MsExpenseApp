import 'package:ms/core/constant/constant.dart';
import 'package:ms/core/local/shared_preferences_utils.dart';

class SharedPrefManager {
  SharedPrefManager._();

  static Future<String?>? getJWTToken() async {
    final result = await SharedPrefUtils.getString(key: JWT_TOKEN);
    return result;
  }

  static Future<bool?>? setJWTToken({required String value}) async {
    final result =
        await SharedPrefUtils.saveString(key: JWT_TOKEN, value: value);
    return result;
  }
}
