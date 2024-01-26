import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../controller/auth_controller.dart';
import '../utility/app_colors.dart';
import '../utility/assets_path.dart';
import '../widgets/shopybay_text.dart';
import 'AuthScreen/email_screen.dart';
import 'bottom_navScreen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    moveToNextScreen();
  }

  void moveToNextScreen() async {
    final isLoggedIn = await Get.find<AuthenticationController>().isLoggedIn();
    log('isLoggedIn: $isLoggedIn');
    await Future.delayed(const Duration(seconds: 2))
        .then((value) => Get.offAll(() => isLoggedIn ? const BottomNavScreen() : const EmailScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Image.asset('assets/images/logo.png'),
            ),
            const SizedBox(height: 10),
            shopyBayText(context),
            const Spacer(),
            const CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
            const SizedBox(height: 20),
            const Text('Version 1.0'),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
