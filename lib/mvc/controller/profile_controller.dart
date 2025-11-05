import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../model/profile_model.dart';

class ProfileController extends GetxController {
  // ------------------ Singleton Support ------------------
  static ProfileController get to => Get.find<ProfileController>();

  RxBool isLoading = false.obs;
  Rx<Profile?> profile = Rx<Profile?>(null);

  final storage = GetStorage();
  final String baseUrl = 'https://engine-stg.shurjopay.com.bd/shurjopayapp-api';

  @override
  void onInit() {
    super.onInit();
    final token = storage.read('token');
    if (token != null && token.isNotEmpty) {
      fetchProfile();
    }
  }

  // ------------------ Get Profile ------------------
  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      final token = storage.read('token'); // 🔥 Always fetch fresh token
      if (token == null || token.isEmpty) {
        Get.snackbar("Error", "Token not found. Please login again.");
        return;
      }

      final response = await http.get(
        Uri.parse('$baseUrl/get-user-profile'),
        headers: {"Authorization": "Bearer $token"},
      );

      print("Profile API raw response: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("Parsed response: $jsonResponse");

        if (jsonResponse['success'] == true) {
          profile.value = Profile.fromJson(jsonResponse['data']);
        } else {
          Get.snackbar("Error", jsonResponse['message'] ?? "Failed to fetch profile");
        }
      } else if (response.statusCode == 401) {
        Get.snackbar("Unauthorized", "Your session has expired. Please login again.");
      } else {
        Get.snackbar("Error", "Server Error: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // ------------------ Update Profile Data ------------------
  Future<void> updateProfileData({
    required String name,
    required String email,
    required String dateOfBirth,
  }) async {
    try {
      isLoading.value = true;
      final token = storage.read('token'); // 🔥 Dynamic token
      if (token == null || token.isEmpty) {
        Get.snackbar("Error", "Token not found. Please login again.");
        return;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/update-user-profile'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "date_of_birth": dateOfBirth,
        }),
      );

      final jsonResponse = jsonDecode(response.body);
      print("Update profile response: $jsonResponse");

      if (jsonResponse['success'] == true) {
        profile.value = Profile.fromJson(jsonResponse['data']);
        Get.snackbar("Success", jsonResponse['message'] ?? "Profile updated");
      } else {
        Get.snackbar("Error", jsonResponse['message'] ?? "Profile update failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // ------------------ Update Profile Image ------------------
  Future<void> updateProfileImage(File imageFile) async {
    try {
      isLoading.value = true;
      final token = storage.read('token'); // 🔥 Dynamic token
      if (token == null || token.isEmpty) {
        Get.snackbar("Error", "Token not found. Please login again.");
        return;
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/update-profile-image'),
      );
      request.headers["Authorization"] = "Bearer $token";
      request.files.add(
        await http.MultipartFile.fromPath('profile_image', imageFile.path),
      );

      final response = await request.send();
      final respStr = await response.stream.bytesToString();
      final jsonResponse = jsonDecode(respStr);
      print("Update image response: $jsonResponse");

      if (response.statusCode == 200 && jsonResponse['success'] == true) {
        profile.update((p0) {
          if (p0 != null) p0.profileImage = jsonResponse['image_url'];
        });
        Get.snackbar("Success", jsonResponse['message'] ?? "Image updated");
      } else {
        Get.snackbar("Error", jsonResponse['message'] ?? "Image upload failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
