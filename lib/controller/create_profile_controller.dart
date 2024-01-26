
import 'package:crapty_bay/controller/auth_controller.dart';
import 'package:crapty_bay/controller/verify_otp_controller.dart';
import 'package:get/get.dart';

import '../data/models/user_profile.dart';
import '../data/service/network_caller.dart';
import '../data/utilities/urls.dart';

class CreateProfileController extends GetxController {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  Future<bool> createProfile(String firstName, String lastName, String mobile,
      String city, String shippingAddress) async {
    Map<String, dynamic> body = {
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'city': city,
      'shippingAddress': shippingAddress,
    };
    _isLoading = true;
    update();
    final response = await NetWorkCaller().postRequest(
      url: Urls.createProfileUrl,
      body: body,
      token: Get.find<VerifyOtpController>().token!,
    );
    _isLoading = false;
    if (response.isSuccess) {
      await Get.find<AuthenticationController>().saveUserDetails(
          Get.find<VerifyOtpController>().token!,
          UserProfile.fromJson(response.responseData['data']));
      update();
      return true;
    } else {
      _errorMessage = 'profile Creation Failed';
      update();
      return false;
    }
  }
}
