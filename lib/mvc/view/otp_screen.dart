import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_button.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNo;

  const OtpScreen({
    super.key,
    required this.mobileNo,
    });

  @override
  State<OtpScreen> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("OTP Verification"),
        backgroundColor: const Color.fromARGB(255, 44, 228, 139),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.asset('assets/images/img1.gif'),
              const SizedBox(height: 20),
              const Text(
                "Enter Verification Code",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "We have sent a verification code to your phone number",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.blueGrey),
              ),
              const SizedBox(height: 40),
              // OTP Input Fields
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
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 44, 228, 139),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 44, 228, 139),
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
              const SizedBox(height: 40),
              // Verify Button
              CustomButton(
                text: "Verify",
                onPressed: () {
                  // TODO: Implement OTP verification logic
                  Get.offAllNamed('/home');
                },
              ),
              const SizedBox(height: 20),
              // Resend Code
              TextButton(
                onPressed: () {
                  // TODO: Implement resend code logic
                },
                child: const Text(
                  "Resend Code",
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
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: FloatingActionButton(
              onPressed: () {
                Get.back(); // Navigate back
              },
              child: const Icon(Icons.arrow_back),
              backgroundColor: const Color.fromARGB(255, 44, 228, 139),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              Get.offAllNamed('/home'); // Navigate to home page
            },
            child: const Icon(Icons.arrow_forward),
            backgroundColor: const Color.fromARGB(255, 44, 228, 139),
          ),
        ],
      ),
    );
  }
}
