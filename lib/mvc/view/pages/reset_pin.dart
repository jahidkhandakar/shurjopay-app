import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class ResetPin extends StatefulWidget {
  const ResetPin({super.key});

  @override
  State<ResetPin> createState() => _ResetPinPageState();
}

class _ResetPinPageState extends State<ResetPin> {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Reset PIN"),
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
                "Reset Your PIN",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Please enter your old PIN and create a new one",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.blueGrey),
              ),
              const SizedBox(height: 20),
              // New PIN
              CustomTextFormField(
                controller: _newPinController,
                label: "New PIN",
                icon: Icons.lock_outline,
                obscureText: true,
              ),
              const SizedBox(height: 15),
              // Confirm New PIN
              CustomTextFormField(
                controller: _confirmPinController,
                label: "Confirm New PIN",
                icon: Icons.lock_outline,
                obscureText: true,
              ),
              const SizedBox(height: 30),
              // Reset Button
              CustomButton(
                text: "Reset PIN",
                onPressed: () {
                  // TODO: Implement PIN reset logic
                  if (_newPinController.text == _confirmPinController.text) {
                    // Show success message
                    Get.snackbar(
                      'Success',
                      'PIN has been reset successfully',
                      backgroundColor: const Color.fromARGB(255, 4, 216, 114),
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
                Get.offAllNamed('/login'); // Navigate back
              },
              child: const Icon(Icons.arrow_back),
              backgroundColor: const Color.fromARGB(255, 4, 216, 114),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              Get.offAllNamed('/home'); // Navigate to login page
            },
            child: const Icon(Icons.forward),
            backgroundColor: const Color.fromARGB(255, 4, 216, 114),
          ),
        ],
      ),
    );
  }
}
