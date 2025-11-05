import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_button_primary.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../theme/app_theme.dart';

class ResetPinScreen extends StatefulWidget {
  const ResetPinScreen({super.key});

  @override
  State<ResetPinScreen> createState() => _ResetPinPageState();
}

class _ResetPinPageState extends State<ResetPinScreen> {
  final TextEditingController _oldPinController = TextEditingController();
  final TextEditingController _newPinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();


  @override
  void dispose() {
    _oldPinController.dispose();
    _newPinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        (Rect bounds) => AppTheme.primaryGradient.createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        ),
                    blendMode: BlendMode.srcIn,
                    child: const Text(
                      "Reset Your PIN",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Enter your new PIN",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // New PIN
                  CustomTextField(
                    controller: _newPinController,
                    label: "New PIN",
                    icon: Icons.lock_outline,
                    obscureText: true,
                  ),
                  const SizedBox(height: 15),
                  // Confirm New PIN
                  CustomTextField(
                    controller: _confirmPinController,
                    label: "Confirm New PIN",
                    icon: Icons.lock_outline,
                    obscureText: true,
                  ),
                  const SizedBox(height: 30),
                  // Reset Button
                  CustomButtonPrimary(
                    text: "SUBMIT",
                    onPressed: () {
                      // TODO: Implement PIN reset logic
                      if (_newPinController.text ==
                          _confirmPinController.text) {
                        // Show success message
                        Get.snackbar(
                          'Success',
                          'PIN has been reset successfully',
                          backgroundColor: AppTheme.primaryColor,
                          colorText: Colors.white,
                        );
                        // Navigate to login page
                        Get.offAllNamed('/login');
                      } else {
                        // Show error message
                        Get.snackbar(
                          'Error',
                          'New PINs do not match',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
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
      //           Get.offAllNamed('/otp'); // Navigate to otp page
      //         },
      //         child: const Icon(Icons.arrow_back),
      //         backgroundColor: AppTheme.primaryColor,
      //       ),
      //     ),
      //     FloatingActionButton(
      //       onPressed: () {
      //         Get.offAllNamed('/login'); // Navigate to login page
      //       },
      //       child: const Icon(Icons.forward),
      //       backgroundColor: AppTheme.primaryColor,
      //     ),
      //   ],
      // ),
    );
  }
}
