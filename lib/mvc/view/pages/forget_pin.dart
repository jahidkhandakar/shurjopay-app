import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_button.dart';

class ForgetPin extends StatefulWidget {
  const ForgetPin({super.key});

  @override
  State<ForgetPin> createState() => _ForgetPinState();
}

class _ForgetPinState extends State<ForgetPin> {
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
        title: const Text("Forget PIN"),
        backgroundColor: const Color.fromARGB(255, 4, 216, 114),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/img1.gif'),
              const SizedBox(height: 5),
              const Text(
                "Forget PIN?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Enter the OTP sent to your registered number",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.blueGrey),
              ),
              const SizedBox(height: 20),
              // Display Phone Number
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 4, 216, 114),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.phone, color: Colors.blueGrey),
                    const SizedBox(width: 10),
                    const Text(
                      "+880 1234567890", // TODO: Replace with actual phone number
                      style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
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
                            color: Color.fromARGB(255, 4, 216, 114),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 4, 216, 114),
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
              // Verify Button
              CustomButton(
                text: "Verify OTP",
                onPressed: () {
                  // TODO: Implement OTP verification logic
                  String otp = _controllers.map((e) => e.text).join();
                  if (otp.length == 6) {
                    Get.offAllNamed('/reset');
                  } else {
                    Get.snackbar(
                      'Error',
                      'Please enter the complete OTP',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              // Resend Code
              TextButton(
                onPressed: () {
                  // TODO: Implement resend code logic
                  Get.snackbar(
                    'Success',
                    'OTP resent to your phone number',
                    backgroundColor: const Color.fromARGB(255, 4, 216, 114),
                    colorText: Colors.white,
                  );
                },
                child: const Text(
                  "Resend Code",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 4, 216, 114),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 50),
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
                Get.offAllNamed('/login'); // Navigate back to login page
              },
              child: const Icon(Icons.arrow_back),
              backgroundColor: const Color.fromARGB(255, 4, 216, 114),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              Get.toNamed('/reset'); // Navigate to reset pin page
            },
            child: const Icon(Icons.forward),
            backgroundColor: const Color.fromARGB(255, 4, 216, 114),
          ),
        ],
      ),
    );
  }
}
