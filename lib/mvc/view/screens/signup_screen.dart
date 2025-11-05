import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/auth_controller.dart';
import '../../../widgets/custom_button_primary.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../theme/app_theme.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();

  final AuthController _authController = AuthController();

  bool isLoading = false;
  String? message;

  void handleSignup() async {
    setState(() {
      isLoading = true;
      message = null;
    });

    print("🔃 Sending signup request...");
    final result = await _authController.signup(
      name: _nameController.text.trim(),
      mobileNo: _mobileController.text.trim(),
      pin: _pinController.text.trim(),
      confirmPin: _confirmPinController.text.trim(),
    );

    setState(() => isLoading = false);

    print(
      "✅ Signup result: success=${result.success}, sp_code=${result.spCode}, message=${result.message}",
    );

    if (result.success) {
      print("👉 Navigating to OTP screen...");
      setState(() => message = "Signup successful!");
      Get.toNamed(
        '/otp',
        arguments: {
          'mobileNo': _mobileController.text.trim(),
          'nextRoute': '/login',  //! Adjust as needed (services)
        },
      );
    } else {
      print("❌ Signup failed: ${result.message}");
      setState(() => message = result.message);
      Get.snackbar(
        "Signup Failed",
        result.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Colors.white),
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
                    color: Colors.black.withOpacity(0.08),
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
                        (Rect bounds) => AppTheme.primaryGradient.createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        ),
                    blendMode: BlendMode.srcIn,
                    child: const Text(
                      "Create your shurjoPay account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Already have an account?",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey,
                      ),
                      children: [
                        TextSpan(
                          text: " login here",
                          style: TextStyle(
                            fontSize: 18,
                            foreground:
                                Paint()
                                  ..shader = AppTheme.primaryGradient
                                      .createShader(
                                        const Rect.fromLTWH(0, 0, 100, 20),
                                      ),
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () => Get.offAllNamed('/login'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    controller: _nameController,
                    label: "Full Name",
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _mobileController,
                    label: "Phone Number",
                    icon: Icons.phone,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _pinController,
                    label: "PIN",
                    icon: Icons.password,
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _confirmPinController,
                    label: "Confirm PIN",
                    icon: Icons.password,
                    obscureText: true,
                  ),
                  const SizedBox(height: 30),
                  CustomButtonPrimary(
                    text: isLoading ? "Signing up..." : "Signup",
                    onPressed: isLoading ? null : handleSignup,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.only(left: 30),
      //       child: FloatingActionButton(
      //         onPressed: () {
      //           Get.offAllNamed('/login');
      //         },
      //         child: const Icon(Icons.arrow_back),
      //         backgroundColor: AppTheme.primaryColor,
      //       ),
      //     ),
      //     FloatingActionButton(
      //       onPressed: () {
      //         Get.toNamed('/home');
      //       },
      //       child: const Icon(Icons.forward),
      //       backgroundColor: AppTheme.primaryColor,
      //     ),
      //   ],
      // ),

    );
  }
}
