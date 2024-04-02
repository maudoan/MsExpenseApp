import 'package:get/get.dart';
import 'package:ms/data/service/base/service.dart';
import 'package:ms/data/service/base/service_api.dart';
import 'package:ms/data/service/business/auth_repository.dart';
import 'package:ms/data/service/business/auth_service.dart';
import 'package:ms/data/service/business/auth_service_api.dart';
import 'package:ms/data/source/business/ms_repositoy.dart';

void setupServiceLocator() {
  Get.put<MsRepository>(ServiceApi(msService: MsService.create()),
      permanent: true);
  Get.put<AuthRepository>(AuthServiceApi(authService: AuthService.create()),
      permanent: true);
}
