import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_button_primary.dart';
import '../../../theme/app_theme.dart';
import '../../controller/auth_controller.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  final AuthController _authController = AuthController();

  late String mobileNo;
  late String nextRoute;

  bool _isLoading = false;
  bool _isResendEnabled = false;
  int _remainingTime = 180;
  int _resendAttempts = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Read mobileNo and nextRoute from Get.arguments only
    mobileNo =
        Get.arguments != null && Get.arguments['mobileNo'] != null
            ? Get.arguments['mobileNo']
            : '';
    nextRoute =
        Get.arguments != null && Get.arguments['nextRoute'] != null
            ? Get.arguments['nextRoute']
            : '/services';
    startCountdown();
  }

  void startCountdown() {
    setState(() {
      _isResendEnabled = false;
      _remainingTime = 10;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        setState(() {
          _isResendEnabled = true;
        });
        timer.cancel();
      }
    });
  }

  Future<void> _resendOtp() async {
    if (_resendAttempts >= 5) {
      Get.snackbar(
        'Limit Reached',
        'You have exceeded the resend limit. Please contact support.',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    setState(() {
      _resendAttempts++;
      _isResendEnabled = false;
      _remainingTime = 180;
    });

    startCountdown();

    try {
      await _authController.resendOtp(mobileNo);
      Get.snackbar(
        'OTP Resent',
        'A new OTP has been sent to your number.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShaderMask(
                    shaderCallback:
                        (bounds) =>
                            AppTheme.primaryGradient.createShader(bounds),
                    blendMode: BlendMode.srcIn,
                    child: const Text(
                      "Enter OTP",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "We’ve sent a verification code to your phone number",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 30),

                  //*___________ OTP input fields____________
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      6,
                      (index) => SizedBox(
                        width: 45,
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppTheme.primaryColor,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppTheme.primaryColor,
                                width: 2,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.length == 1 && index < 5) {
                              _focusNodes[index + 1].requestFocus();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  /// Verify Button
                  CustomButtonPrimary(
                    text: _isLoading ? "Verifying..." : "VERIFY",
                    onPressed:
                        _isLoading
                            ? null
                            : () async {
                              final otp =
                                  _controllers.map((c) => c.text).join();
                              if (otp.length != 6) {
                                Get.snackbar(
                                  'Error',
                                  'Please enter the 6-digit OTP',
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                                return;
                              }
                              setState(() => _isLoading = true);
                              try {
                                final message = await _authController.verifyOtp(
                                  mobileNo,
                                  otp,
                                );
                                Get.snackbar(
                                  'Success',
                                  message,
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                );
                                Get.toNamed(nextRoute, arguments: {
                                  'mobileNo': mobileNo,
                                });
                              } catch (e) {
                                Get.snackbar(
                                  'Error',
                                  e.toString(),
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                              } finally {
                                setState(() => _isLoading = false);
                              }
                            },
                  ),
                  const SizedBox(height: 20),

                  //* Resend OTP button + timer
                  TextButton(
                    onPressed: _isResendEnabled ? _resendOtp : null,
                    child: ShaderMask(
                      shaderCallback:
                          (Rect bounds) =>
                              AppTheme.primaryGradient.createShader(bounds),
                      blendMode: BlendMode.srcIn,
                      child: Text(
                        _isResendEnabled
                            ? "Resend Code"
                            : "Resend in ${_remainingTime ~/ 60}:${(_remainingTime % 60).toString().padLeft(2, '0')}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      /// Optional nav buttons
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.only(left: 30),
      //       child: FloatingActionButton(
      //         onPressed: () {
      //           Get.offAllNamed('/recovery');
      //         },
      //         child: const Icon(Icons.arrow_back),
      //         backgroundColor: AppTheme.primaryColor,
      //       ),
      //     ),
      //     FloatingActionButton(
      //       onPressed: () {
      //         Get.offAllNamed('/reset');
      //       },
      //       child: const Icon(Icons.arrow_forward),
      //       backgroundColor: AppTheme.primaryColor,
      //     ),
      //   ],
      // ),
    );
  }
}
