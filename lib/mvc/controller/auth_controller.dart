import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user_model.dart';

class AuthController {
  final String baseUrl = "https://engine-stg.shurjopay.com.bd/";

  //* LOGIN METHOD-------------------------------------------------
  Future<User> login(String mobileNo, String pin) async {
    final String loginUrl = "$baseUrl/shurjopay-api/app-login";

    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"mobile_no": mobileNo, "pin": pin}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception("Login failed: ${response.body}");
    }
  }

  //* SIGNUP METHOD-------------------------------------------------
  Future<String> signup({
    required String name,
    required String mobileNo,
    required String pin,
  }) async {
    final String signupUrl = "$baseUrl/shurjopay-api/app-signup";

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

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['message'];
    } else {
      throw Exception("Signup failed: ${response.body}");
    }
  }

  //*VERIFY OTP METHOD-------------------------------------------------
  Future<String> verifyOtp(String mobileNo, String verifyCode) async {
    final String url = "$baseUrl/shurjopay-api/app-verify-account";

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"mobile_no": mobileNo, "verify_code": verifyCode}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['message'];
    } else {
      throw Exception("OTP verification failed: ${response.body}");
    }
  }
  

}
