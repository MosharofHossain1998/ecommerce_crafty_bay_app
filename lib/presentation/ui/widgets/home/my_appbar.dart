import 'package:crapty_bay/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../screens/AuthScreen/create_profile_screen.dart';
import '../../screens/AuthScreen/email_screen.dart';
import '../shopybay_text.dart';

AppBar  myAppBar(BuildContext context) {
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Image.asset('assets/images/logo_nav.png',fit: BoxFit.contain,),
    ),
    title: shopyBayText(context, fontSize: 25),
    actions: [
      InkWell(
        onTap: () {
          //Get.find<AuthController>().clearAuthData();
         // Get.offAll(() => const EmailScreen());
          Get.to(() => const ProfileScreen());
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Icon(Icons.person_outline_sharp)),
        ),
      ),
      InkWell(
        onTap: () {
          Get.find<AuthenticationController>().clearAuthData();
          Get.offAll(() => const EmailScreen());
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: CircleAvatar(
              backgroundColor: Colors.grey[200], child: Icon(Icons.logout)),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: Icon(Icons.add_alert_rounded)),
      ),
    ],
  );
}

