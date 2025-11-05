class ApiResultModel {
  final bool success;
  final String message;
  final String spCode;
  final Map<String, dynamic>? data;

  ApiResultModel({
    required this.success, 
    required this.message, 
    required this.spCode,
    this.data
  });
}
