import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms/core/base/page_material_route.dart';
import 'package:ms/data/model/user.dart';
import 'package:ms/view/dashboard/cubit/dashboard_cubit.dart';
import 'package:ms/view/home/cubit/home_cubit.dart';
import 'package:ms/view/home/home_screen.dart';
import 'package:ms/view/login/cubit/login_cubit.dart';
import 'package:ms/view/login/login_screen.dart';
import 'package:ms/view/splash/splash_screen.dart';

enum AppRoute { SPALSH_SCREEN, LOGIN_SCREEN, HOME_SCREEN }

extension AppRouteExt on AppRoute {
  String get name {
    switch (this) {
      case AppRoute.SPALSH_SCREEN:
        return '/splash';
      case AppRoute.LOGIN_SCREEN:
        return '/login';
      case AppRoute.HOME_SCREEN:
        return '/home';
    }
  }

  static AppRoute? from(String? name) {
    for (final item in AppRoute.values) {
      if (item.name == name) {
        return item;
      }
    }
    return null;
  }

  static Route generateRoute(RouteSettings settings) {
    switch (AppRouteExt.from(settings.name)) {
      case AppRoute.SPALSH_SCREEN:
        return PageMaterialRoute(
            settings: settings,
            page: () => const SplashScreen(),
            bindings: [
              // BindingsBuilder.put(() => SplashCubit(Get.find())),
            ],
            transition: Transition.fade);
      case AppRoute.LOGIN_SCREEN:
        return PageMaterialRoute(
            settings: settings,
            page: () => const LoginScreen(),
            bindings: [
              BindingsBuilder.put(() => LoginCubit(Get.find(), Get.find())),
            ],
            transition: Transition.fade);
      case AppRoute.HOME_SCREEN:
        final dynamic argument = settings.arguments;
        final User user = argument;
        return PageMaterialRoute(
            settings: settings,
            page: () => HomeScreen(user: user),
            bindings: [
              BindingsBuilder.put(() => HomeCubit(Get.find())),
            ],
            transition: Transition.fade);
      default:
        return GetPageRoute(
          settings: settings,
          curve: Curves.ease,
          transition: Transition.rightToLeft,
          page: () => const SplashScreen(),
        );
    }
  }

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static Route<dynamic> bindingRoute(RouteSettings settings) {
    return AppRouteExt.generateRoute(settings);
  }
}
