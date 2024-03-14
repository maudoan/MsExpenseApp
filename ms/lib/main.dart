import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms/route/routes.dart';
RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
      return GetMaterialApp(
      title: 'My Sunshine',
      navigatorKey: AppRouteExt.navigatorKey,
      key: key,
      initialRoute: AppRoute.LOGIN_SCREEN.name,
      onGenerateRoute: AppRouteExt.bindingRoute,
      initialBinding: AppBinding(),
      navigatorObservers: <NavigatorObserver>[routeObserver],
    );
  }
}


class AppBinding extends Bindings {
  @override
  void dependencies() {
    injectService();
  }

  void injectService() {}
}

