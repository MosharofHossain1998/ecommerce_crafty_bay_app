import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../controller/sentEmailOtpController.dart';
import '../../../../controller/verify_otp_controller.dart';
import '../../utility/app_colors.dart';
import '../../utility/assets_path.dart';
import '../../widgets/PinCodeTextField.dart';
import '../../widgets/shopybay_text.dart';
import '../bottom_navScreen.dart';
import 'create_profile_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.email});

  final String email;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final sentEmailOtpController = Get.find<SentEmailOtpController>();
  final TextEditingController _otpController = TextEditingController();
  bool _countDown = true;
  int secondsRemaining = 120;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if(mounted)
      setState(() {
        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          _countDown = false;
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    // _otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Image.asset('assets/images/logo.png'),
              ),
              shopyBayText(context),
              const SizedBox(height: 20),
              Text(
                'Enter OTP Code',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,
              ),
              const SizedBox(height: 10),
              Text(
                'A 4 digit otp has been sent to your email address',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleSmall,
              ),
              const SizedBox(height: 25),

              /// This is the PinCodeTextField widget from the pin_code_fields package
              buildPinCodeTextField(context, _otpController),

              const SizedBox(
                height: 20,
              ),

              GetBuilder<VerifyOtpController>(
                builder: (verifyOtpController) {
                  return Visibility(
                    visible: verifyOtpController.isLoading == false,
                    replacement: const CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () => verifyOtpPressed(verifyOtpController),
                          child: const Text('Verify'),
                    ),
                  ),);
                },
              ),
              const SizedBox(height: 30),
              RichText(
                text: TextSpan(
                  text: _countDown
                      ? 'The code will expire in '
                      : 'The code has expired',
                  style: const TextStyle(color: Colors.grey, fontSize: 15),
                  children: [
                    TextSpan(
                      text: _countDown ? '${secondsRemaining}s' : '',
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              _countDown
                  ? const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Resend Code',
                  style: TextStyle(color: Colors.grey),
                ),
              )
                  : TextButton(
                onPressed: () {
                  _countDown = true;
                  secondsRemaining = 120;
                  startTimer();
                  _otpController.clear();
                  sentEmailOtpController.sentEmailOtp(widget.email);
                  setState(() {});
                },
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primaryColor,
                ),
                child: const Text('Resend Code'),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery
                        .of(context)
                        .viewInsets
                        .bottom),
              ),
              Spacer(),
            ],
          ),
        ));
  }

  void verifyOtpPressed(VerifyOtpController verifyOtpController) async {
    final isVerified = await verifyOtpController.verifyOtp(
        widget.email, _otpController.text);
    if (isVerified) {
      if (verifyOtpController.isProfileCompleted) {
        Get.to(() => const BottomNavScreen());
      }
      else {
        Get.to(() => const ProfileScreen());
      }
    } else {
      Get.showSnackbar(const GetSnackBar(
        message: 'Please enter valid otp',
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ));
    }
  }
}
