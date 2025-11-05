import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shurjopay2/mvc/model/api_result_model.dart';
import 'package:shurjopay2/utils/api_response_handler.dart';
import 'package:shurjopay2/utils/error_messages.dart';
import '../model/user_model.dart';
import '../../utils/custom_exception.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class AuthController {
  final String baseUrl = "https://engine-stg.shurjopay.com.bd/";

  //* SIGNUP METHOD-------------------------------------------------
  Future<ApiResultModel> signup({
    required String name,
    required String mobileNo,
    required String pin,
    required String confirmPin,
  }) async {
    final String signupUrl = "$baseUrl/shurjopayapp-api/app-signup";

    final response = await http.post(
      Uri.parse(signupUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "mobile_no": mobileNo,
        "pin": pin,
        "pin_confirmation": pin,
      }),
    );

    final data = json.decode(response.body);
    print("✅ Signup response: $data");

    return ApiResponseHandler.handleResponse(
      statusCode: response.statusCode,
      json: data,
      successStatusCodes: [200, 201],
      successSpCodes: [
        "201",
        "206",
      ], // treat both signup & otp resend as success
    );

  }

  //* LOGIN METHOD-------------------------------------------------
  Future<User> login(String mobileNo, String pin) async {
    final String loginUrl = "$baseUrl/shurjopayapp-api/app-login";

    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"mobile_no": mobileNo, "pin": pin}),
    );

    final data = json.decode(response.body);
    print("✅ Login response: $data");

    if (response.statusCode == 200) {
      final spCode = data['sp_code']?.toString() ?? "unknown";

      if (spCode == "200") {
        return User.fromJson(data);
      } else if (spCode == "105") {
        // User not verified, backend already resent OTP
        Get.toNamed('/otp', arguments: {'mobileNo': mobileNo});
        Get.snackbar(
          "Verification Needed",
          "Your mobile number is not verified. We’ve resent the OTP.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.orangeAccent,
          colorText: Colors.white,
        );
        throw CustomException(
          "Your mobile number is not verified. OTP resent.",
        );
      } else {
        final apiMessage = data['message']?.toString();
        final message = apiMessage ?? ErrorMessages.fromSpCode(spCode);
        throw CustomException(message);
      }
    } else {
      final apiMessage = data['message']?.toString();
      final spCode = data['sp_code']?.toString() ?? "unknown";
      final message = apiMessage ?? ErrorMessages.fromSpCode(spCode);
      throw CustomException("HTTP ${response.statusCode}: $message");
    }
  }

  //*VERIFY OTP METHOD-------------------------------------------------
  Future<String> verifyOtp(String mobileNo, String verifyCode) async {
    final String url = "$baseUrl/shurjopayapp-api/app-verify-account";

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"mobile_no": mobileNo, "verify_code": verifyCode}),
    );

    final data = json.decode(response.body);
    print("✅ OTP Verify Response: $data");

    if (response.statusCode == 200) {
      final spCode = data['sp_code']?.toString();

      if (spCode == "200") {
        final token = data['token'];
        final customerName = data['customer_name'];

        // Save token + user info to local storage
        final storage = GetStorage();
        await storage.write('token', token);
        await storage.write('customer_name', customerName);
        await storage.write('mobile_no', mobileNo);

        return data['message']; //"Your account has been activated"
      } else {
        final apiMessage = data['message']?.toString();
        throw CustomException(apiMessage ?? "OTP verification failed");
      }
    } else {
      throw Exception("OTP verification failed: ${response.body}");
    }
  }

  //* RESEND OTP METHOD-------------------------------------------------
  Future<void> resendOtp(String mobileNo) async {
    final String url = "$baseUrl/shurjopayapp-api/app-resend-code.j";

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"mobile_no": mobileNo}),
    );
    print("🔁 Raw Response: ${response.body}");
    final data = json.decode(response.body);
    print("🔁 Resend OTP Response: $data");

    final spCode = data['sp_code']?.toString() ?? "unknown";

    print("Response Status Code: ${response.statusCode}");
    print("🔁 SP Code: $spCode");

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (spCode.startsWith("2")) {
        // OTP resent successfully
        print("OTP resent successfully.");
        Get.snackbar(
          "OTP Resent",
          "We’ve resent the OTP to your mobile number.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        return;
      } else {
        final apiMessage = data['message']?.toString();
        final message = apiMessage ?? ErrorMessages.fromSpCode(spCode);
        throw CustomException(message);
      }
    } else {
      final apiMessage = data['message']?.toString();
      final message = apiMessage ?? "Something went wrong.";
      throw CustomException("HTTP ${response.statusCode}: $message");
    }
  }

  //*PIN RESET METHOD----------------------------------------------------
  Future<void> reset(String mobileNo, String newPin, String confirmPin) async {
    final String resetUrl = "$baseUrl/shurjopayapp-api/app-reset-pass";

    final response = await http.post(
      Uri.parse(resetUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "mobile_no": mobileNo,
        "c_pin": newPin,
        "c_pin_confirmation": confirmPin,
      }),
    );

    final data = json.decode(response.body);
    print("🔄 Reset Response: $data");
    final spCode = data['sp_code']?.toString() ?? "unknown";
    print("🔄 Response Status Code: ${response.statusCode}");
    print("🔄 SP Code: $spCode");

    if (response.statusCode == 200) {
      if (spCode == 200) {
        print("PIN reset successfully.");
        Get.snackbar(
          "PIN Reset",
          "New PIN is added to your mobile number.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        await Future.delayed(const Duration(seconds: 1));
        Get.offAllNamed('/login');
      } else {
        final apiMessage = data['message']?.toString();
        final message = apiMessage ?? ErrorMessages.fromSpCode(spCode);
        throw CustomException(message);
      }
    } else {
      final apiMessage = data['message']?.toString();
      final message = apiMessage ?? "Something went wrong.";
      throw CustomException("HTTP ${response.statusCode}:${message}");
    }
  }

  //*LOGOUT METHOD-------------------------------------------------------
  Future<void> logout() async {
    final String logoutUrl = "$baseUrl/shurjopayapp-api/app-logout";
    final token = GetStorage().read('token');

    final response = await http.post(
      Uri.parse(logoutUrl),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      print("✅ Logout successful.");
      // Clear local token storage
      GetStorage().erase(); // or remove('token') + remove('user_name')
    } else {
      print("❌ Logout failed: ${response.body}");
      throw Exception("Logout failed: ${response.body}");
    }
  }
}
