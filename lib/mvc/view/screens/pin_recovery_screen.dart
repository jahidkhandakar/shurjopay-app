import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shurjopay2/widgets/custom_text.dart';
import '../../../widgets/custom_button_primary.dart';
import '../../../widgets/custom_text_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PinRecoveryScreen extends StatefulWidget {
  const PinRecoveryScreen({super.key});

  @override
  State<PinRecoveryScreen> createState() => _ForgetPinState();
}

class _ForgetPinState extends State<PinRecoveryScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final String baseUrl = "https://engine-stg.shurjopay.com.bd/";

  @override
  void dispose() {
    _phoneNumberController.dispose();
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
                  CustomText(
                    text: "Recover PIN",
                    textAlign: TextAlign.center,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Enter your Phone Number",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  //*Phone Number Input Field---------------------------
                  CustomTextField(
                    label: "Phone Number",
                    icon: Icons.phone,
                    controller: _phoneNumberController,
                  ),
                  const SizedBox(height: 30),
                  // Continue Button
                  CustomButtonPrimary(
                    text: "CONTINUE",
                    onPressed: () async {
                      final phone = _phoneNumberController.text.trim();

                      if (phone.isEmpty) {
                        Get.snackbar(
                          "Missing Info",
                          "Please enter your phone number",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                        );
                        return;
                      }

                      try {
                        final url = Uri.parse(
                          "${baseUrl}shurjopayapp-api/app-forgot-pass",
                        );

                        final response = await http.post(
                          url,
                          headers: {"Content-Type": "application/json"},
                          body: jsonEncode({"mobile_no": phone}),
                        );

                        if (response.statusCode == 200) {
                          final data = jsonDecode(response.body);

                          if (data['sp_code'] == '200') {
                            Get.snackbar(
                              "Success",
                              data['message'],
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                            );

                            Get.toNamed(
                              '/otp',
                              arguments: {
                                'mobileNo': phone,
                                'nextRoute': '/reset',
                              },
                            );
                          } else {
                            Get.snackbar(
                              "Error",
                              data['message'] ?? "Something went wrong",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.orange,
                              colorText: Colors.white,
                            );
                          }
                        } else {
                          Get.snackbar(
                            "Server Error",
                            "Status Code: ${response.statusCode}",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      } catch (e) {
                        Get.snackbar(
                          "Exception",
                          "Failed to connect to the server",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                        print("Error: $e");
                      }
                    },
                  ),
                  // const SizedBox(height: 20),
                  // // Place NavigationButton at the bottom of the column
                  // const NavigationButton(
                  //   frontNavigation: '/otp',
                  //   backNavigation: '/login',
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
