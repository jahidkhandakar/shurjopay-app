import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shurjopay2/mvc/controller/profile_controller.dart';
import '../../../utils/custom_exception.dart';
import '../../../theme/app_theme.dart';
import '../../controller/token_service.dart';
import '../../controller/auth_controller.dart';
import '../../model/user_model.dart';
import '../../../widgets/custom_button_primary.dart';
import '../../../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final FocusNode pinFocusNode = FocusNode();
  final AuthController _authController = AuthController();

  bool isLoading = false;
  String? error;

  @override
  void initState() {
    super.initState();

    // Check arguments from OTP screen
    final args = Get.arguments as Map<String, dynamic>?;
    final prefilledMobileNo = args?['mobileNo'] ?? '';

    if (prefilledMobileNo.isNotEmpty) {
      mobileController.text = prefilledMobileNo;

      // Automatically focus PIN field
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(pinFocusNode);
      });
    }
  }

  void handleLogin() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      User user = await _authController.login(
        mobileController.text.trim(),
        pinController.text.trim(),
      );

      // Save token and username
      TokenService.save(user.accessToken, user.customerName);

      // Fetch profile after login
      await ProfileController.to.fetchProfile();

      setState(() => isLoading = false);

      // Debug log
      print("Welcome: ${user.customerName}");
      print("Your Token: ${user.accessToken}");

      // Navigate to home
      Get.offAllNamed('/services');
    } catch (e) {
      setState(() => isLoading = false);

      print("⚠️ Exception caught: ${e.runtimeType} - $e");
      final message =
          (e is CustomException) ? e.message : "An unexpected error occurred.";

      Get.snackbar(
        "Login Failed",
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
            ),
            child: IntrinsicHeight(
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  margin:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ShaderMask(
                        shaderCallback: (Rect bounds) =>
                            AppTheme.primaryGradient.createShader(
                              Rect.fromLTWH(
                                0,
                                0,
                                bounds.width,
                                bounds.height,
                              ),
                            ),
                        blendMode: BlendMode.srcATop,
                        child: const Text(
                          "Welcome Back!",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Login with your shurjoPay account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        controller: mobileController,
                        label: "Phone Number",
                        icon: Icons.phone,
                      ),
                      const SizedBox(height: 18),
                      CustomTextField(
                        controller: pinController,
                        focusNode: pinFocusNode,
                        label: "PIN",
                        icon: Icons.password,
                        obscureText: true,
                      ),
                      const SizedBox(height: 24),
                      CustomButtonPrimary(
                        text: isLoading ? "Logging in..." : "Login",
                        onPressed: isLoading ? null : handleLogin,
                      ),
                      if (error != null) ...[
                        const SizedBox(height: 16),
                        Text(error!, style: const TextStyle(color: Colors.red)),
                      ],
                      const SizedBox(height: 18),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Don't have an account?",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.blueGrey,
                          ),
                          children: [
                            TextSpan(
                              text: " Create account",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 20, 218, 122),
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.offAllNamed('/signup'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () => Get.offAllNamed('/recovery'),
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) =>
                              AppTheme.primaryGradient.createShader(
                                Rect.fromLTWH(
                                  0,
                                  0,
                                  bounds.width,
                                  bounds.height,
                                ),
                              ),
                          blendMode: BlendMode.srcATop,
                          child: const Text(
                            "Forget PIN?",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
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
        ),
      ),
      // floatingActionButton: SafeArea(
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.only(left: 30),
      //         child: ShaderMask(
      //           shaderCallback: (Rect bounds) =>
      //               AppTheme.primaryGradient.createShader(
      //                 Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      //               ),
      //           blendMode: BlendMode.srcATop,
      //           child: FloatingActionButton(
      //             onPressed: () => Get.offAllNamed('/'),
      //             child: const Icon(Icons.arrow_back),
      //             backgroundColor: Colors.white,
      //             foregroundColor: Colors.black,
      //           ),
      //         ),
      //       ),
      //       ShaderMask(
      //         shaderCallback: (Rect bounds) =>
      //             AppTheme.primaryGradient.createShader(
      //               Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      //             ),
      //         blendMode: BlendMode.srcATop,
      //         child: FloatingActionButton(
      //           onPressed: () => Get.offAllNamed('/signup'),
      //           child: const Icon(Icons.arrow_forward),
      //           backgroundColor: Colors.white,
      //           foregroundColor: Colors.white,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
