import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../model/transaction_model.dart';

class TransactionController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<TransactionModel> transactions = <TransactionModel>[].obs;

  final storage = GetStorage();
  late final String? token;
  final String baseUrl = 'https://engine-stg.shurjopay.com.bd/shurjopayapp-api';

  @override
  void onInit() {
    super.onInit();
    token = storage.read('token');
    print("Token used for transaction API: $token");
    fetchTransactions();
  }

  //*____________________________ Fetch Transactions ___________________________
  Future<void> fetchTransactions() async {
    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse('$baseUrl/get-user-transactions'),
        headers: {"Authorization": "Bearer $token"},
      );

      print("Transaction API raw response: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['success'] == true) {
          var list = jsonResponse['data'] as List;
          if (list.isEmpty) {
            print("No transactions found, using mock data...");
            transactions.assignAll(_mockTransactions());
          } else {
            transactions.value =
                list.map((e) => TransactionModel.fromJson(e)).toList();
          }
        } else {
          Get.snackbar(
            "Error",
            jsonResponse['message'] ?? "Failed to fetch transactions",
          );
        }
      } else {
        Get.snackbar("Error", "Server Error: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //*____________________________ Mock Data ___________________________
  List<TransactionModel> _mockTransactions() {
    return [
      TransactionModel(
        invoiceNo: "spay876512349",
        customerOrderId: "order001",
        amountReceived: "1200.00",
        currency: "BDT",
        spCode: 1000,
        createdAt: "2025-07-28 12:30:00",
        cardNumber: "400000xxxxxx1091",
        username: "mockuser",
        methodName: "UCB VISA",
        cusName: "John Doe",
        cusPhone: "01700000000",
        cusEmail: "john@doe.com",
        merchantName: "ShurjoPay",
      ),
      TransactionModel(
        invoiceNo: "spay786542159",
        customerOrderId: "order002",
        amountReceived: "500.50",
        currency: "BDT",
        spCode: 1000,
        createdAt: "2025-07-27 15:00:00",
        cardNumber: "CELLFIN",
        username: "mockuser",
        methodName: "Cellfin",
        cusName: "Jane Doe",
        cusPhone: "01711111111",
        cusEmail: "jane@doe.com",
        merchantName: "ShurjoPay",
      ),
      TransactionModel(
        invoiceNo: "spay456781245",
        customerOrderId: "order003",
        amountReceived: "300.00",
        currency: "BDT",
        spCode: 1000,
        createdAt: "2025-07-26 09:20:00",
        cardNumber: "400000xxxxxx8765",
        username: "mockuser",
        methodName: "MasterCard",
        cusName: "Robert Brown",
        cusPhone: "01722222222",
        cusEmail: "robert@brown.com",
        merchantName: "ShurjoPay",
      ),
    ];
  }
}
