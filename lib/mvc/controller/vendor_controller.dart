import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import '../model/vendor_model.dart';
import '../../utils/custom_exception.dart';

class VendorController {
  final String baseUrl = "https://engine-stg.shurjopay.com.bd/";
  final storage = GetStorage();

  Future<List<Vendor>> fetchVendorsBySubCategory(int subCategoryId) async {
    final token = storage.read('token');
    final url = "$baseUrl/shurjopayapp-api/service-subcategories/vendors";

    print("🔍 Fetching vendors for SubCategory ID: $subCategoryId");
    print("➡️ Request URL: $url");

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"sub_category_id": "$subCategoryId", }),
    );

    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      return jsonData.map((item) => Vendor.fromJson(item)).toList();
    } else {
      throw CustomException("HTTP ${response.statusCode}: ${response.body}");
    }
  }
}
