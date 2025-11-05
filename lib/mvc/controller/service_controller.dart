import 'dart:convert';
import 'package:http/http.dart' as http;
import 'token_service.dart';
import '../model/service_category_model.dart';

class ServiceController {
  final String baseUrl = "https://engine-stg.shurjopay.com.bd/";

  Future<List<ServiceCategory>> fetchServiceCategoriesWithSubs() async {
    final token = TokenService.token;

    if (token == null) {
      throw Exception("❌ No token found. Please log in first.");
    }

    final String url = "$baseUrl/shurjopayapp-api/service-categories";

    print("🔑 Using token: $token");
    print("📡 Requesting: $url");

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print("📥 Status: ${response.statusCode}");
    print("📦 Body: ${response.body}");

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      if (decoded is List) {
        return decoded
            .map<ServiceCategory>((e) => ServiceCategory.fromJson(e))
            .toList();
      } else {
        throw Exception("Expected a list but got: ${decoded.runtimeType}");
      }
    } else {
      final error = jsonDecode(response.body);
      final message = error['message'] ?? 'Unknown error';
      throw Exception("Failed to fetch service categories: $message");
    }
  }
}
