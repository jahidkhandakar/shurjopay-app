import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shurjopay2/mvc/controller/token_service.dart';
import '../model/banner_model.dart';

class BannerController {
  final String baseUrl = "https://engine-stg.shurjopay.com.bd";

  Future<List<PromotionalBanner>> fetchBanners() async {
    final url = "$baseUrl/shurjopayapp-api/promotional-banners";
    final token = TokenService.token;

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      print("📦 Banner API Response: $data");

      if (data is List) {
        return data
            .map<PromotionalBanner>((e) => PromotionalBanner.fromJson(e))
            .toList();
      } else {
        throw Exception("Unexpected response format");
      }
    } else {
      throw Exception("Failed to load banners: ${response.statusCode}");
    }
  }
}
