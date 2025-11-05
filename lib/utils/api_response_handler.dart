import '../mvc/model/api_result_model.dart';

class ApiResponseHandler {
  static ApiResultModel handleResponse({
    required int statusCode,
    required Map<String, dynamic> json,
    List<int> successStatusCodes = const [200, 201], // default HTTP success
    List<String> successSpCodes = const ["200"],     // default sp_code success
  }) {
    final spCode = json['sp_code']?.toString() ?? "unknown";
    final apiMessage = json['message']?.toString() ?? "No message";

    print("📡 API Response => HTTP $statusCode | sp_code: $spCode | message: $apiMessage");

    final statusOk = successStatusCodes.contains(statusCode);
    final spOk = successSpCodes.contains(spCode);

    if (statusOk && spOk) {
      return ApiResultModel(
        success: true,
        message: "$apiMessage (sp_code: $spCode)",
        spCode: spCode,
        data: json,
      );
    } else {
      return ApiResultModel(
        success: false,
        message: "HTTP $statusCode: $apiMessage (sp_code: $spCode)",
        spCode: spCode,
        data: json,
      );
    }
  }
}
