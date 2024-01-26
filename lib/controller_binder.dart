import 'package:crapty_bay/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'controller/category_list_controller.dart';
import 'controller/counter_controller.dart';
import 'controller/create_profile_controller.dart';
import 'controller/home_carousel_product_controller.dart';
import 'controller/main_bottomNavController.dart';
import 'controller/new_product_controller.dart';
import 'controller/popular_product_controller.dart';
import 'controller/product_controller.dart';
import 'controller/read_profile_controller.dart';
import 'controller/sentEmailOtpController.dart';
import 'controller/special_product_controller.dart';
import 'controller/verify_otp_controller.dart';

class GetBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainBottomNavController());
    Get.put(SentEmailOtpController());
    Get.put(VerifyOtpController());
    Get.put(ReadProfileController());
    Get.put(CounterController());
    Get.put(AuthenticationController());
    Get.put(CreateProfileController());
    Get.put(HomeCarouselProductController());
    Get.put(CategotyListController());
    Get.put(PopularProductController());
    Get.put(SpecialProductController());
    Get.put(NewProductController());
    Get.put(ProductController());
  }
}

