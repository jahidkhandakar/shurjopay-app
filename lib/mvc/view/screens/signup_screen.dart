import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/auth_controller.dart';
import 'otp_screen.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final AuthController _authController = AuthController();

  bool isLoading = false;
  String? message;

  void handleSignup() async {
    setState(() {
      isLoading = true;
      message = null;
    });

    try {
      final result = await _authController.signup(
        name: _nameController.text.trim(),
        mobileNo: _mobileController.text.trim(),
        pin: _pinController.text.trim(),
      );

      setState(() => message = result);

      // Navigate to OTP Screen
      Get.offAll(() => OtpScreen(mobileNo: _mobileController.text.trim()));
    } catch (e) {
      setState(() => message = "Signup failed: ${e.toString()}");
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Sign Up"),
        backgroundColor: const Color.fromARGB(255, 44, 228, 139),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image.asset('assets/images/img1.gif'),
              const Text(
                "Create your shurjoPay account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 5),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Already have an account?",
                  style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
                  children: [
                    TextSpan(
                      text: " login here",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 44, 228, 139),
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.offAllNamed('/login'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                controller: _nameController,
                label: "Full Name",
                icon: Icons.person,
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: _mobileController,
                label: "Phone Number",
                icon: Icons.phone,
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: _pinController,
                label: "PIN",
                icon: Icons.password,
                obscureText: true,
              ),
              const SizedBox(height: 30),
              CustomButton(
                text: isLoading ? "Signing up..." : "Signup",
                onPressed: isLoading ? null : handleSignup,
              ),
              if (message != null) ...[
                const SizedBox(height: 20),
                Text(
                  message!,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/home'),
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
