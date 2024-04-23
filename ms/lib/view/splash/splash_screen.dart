import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms/route/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MySunshine'),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () async {
            Get.offAllNamed(AppRoute.LOGIN_SCREEN.name);
          },
          color: const Color.fromRGBO(143, 148, 251, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Text(
              "Login",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
        ),
      ),
    );
  }
}