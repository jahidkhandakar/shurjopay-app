import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../../model/user_model.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final AuthController _authController = AuthController();

  bool isLoading = false;
  String? error;

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

      setState(() => isLoading = false);

      // Navigate to home
      Get.offAllNamed('/home');

      // Optional: Show token dialog
      // showDialog(
      //   context: context,
      //   builder: (_) => AlertDialog(
      //     title: Text("Welcome ${user.customerName}"),
      //     content: Text("Token: ${user.accessToken}"),
      //   ),
      // );
    } catch (e) {
      setState(() {
        isLoading = false;
        error = "Login failed: ${e.toString()}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: const Color.fromARGB(255, 44, 228, 139),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/img1.gif'),
            const SizedBox(height: 20),
            const Text(
              "Login with your shurjoPay account",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "Don't have an account?",
                style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
                children: [
                  TextSpan(
                    text: " Create account",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 44, 228, 139),
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Get.offAllNamed('/signup'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            CustomTextFormField(
              controller: mobileController,
              label: "Phone Number",
              icon: Icons.phone,
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              controller: pinController,
              label: "PIN",
              icon: Icons.password,
              obscureText: true,
            ),
            const SizedBox(height: 25),
            CustomButton(
              text: isLoading ? "Logging in..." : "Login",
              onPressed: isLoading ? null : handleLogin,
            ),
            if (error != null) ...[
              const SizedBox(height: 20),
              Text(error!, style: const TextStyle(color: Colors.red)),
            ],
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Get.offAllNamed('/forget'),
              child: const Text(
                "Forget PIN?",
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 44, 228, 139),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: FloatingActionButton(
              onPressed: () => Get.offAllNamed('/'),
              child: const Icon(Icons.arrow_back),
              backgroundColor: const Color.fromARGB(255, 44, 228, 139),
            ),
          ),
          FloatingActionButton(
            onPressed: () => Get.offAllNamed('/signup'),
            child: const Icon(Icons.arrow_forward),
            backgroundColor: const Color.fromARGB(255, 44, 228, 139),
          ),
        ],
      ),
    );
  }
}
