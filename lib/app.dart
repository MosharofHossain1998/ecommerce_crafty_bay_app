import 'package:crapty_bay/presentation/ui/screens/splash_screen.dart';
import 'package:crapty_bay/presentation/ui/utility/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller_binder.dart';

class CraftyBay extends StatelessWidget {
  const CraftyBay({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:const SplashScreen() ,
      theme: AppThemeData.lightThemeData,
      initialBinding: GetBinding(),
    );
  }
}