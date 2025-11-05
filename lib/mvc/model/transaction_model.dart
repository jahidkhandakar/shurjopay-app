class TransactionModel {
  final String invoiceNo;
  final String customerOrderId;
  final String amountReceived;
  final String? currency;
  final int spCode;
  final String createdAt;
  final String? cardNumber;
  final String username;
  final String methodName;
  final String cusName;
  final String cusPhone;
  final String cusEmail;
  final String merchantName;

  TransactionModel({
    required this.invoiceNo,
    required this.customerOrderId,
    required this.amountReceived,
    required this.currency,
    required this.spCode,
    required this.createdAt,
    required this.cardNumber,
    required this.username,
    required this.methodName,
    required this.cusName,
    required this.cusPhone,
    required this.cusEmail,
    required this.merchantName,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      invoiceNo: json['invoice_no'] ?? '',
      customerOrderId: json['customer_order_id'] ?? '',
      amountReceived: json['amount_recived'] ?? '0.0',
      currency: json['currency'],
      spCode: json['sp_code'] ?? 0,
      createdAt: json['created_at'] ?? '',
      cardNumber: json['card_number'],
      username: json['username'] ?? '',
      methodName: json['method_name'] ?? '',
      cusName: json['cus_name'] ?? '',
      cusPhone: json['cus_phone'] ?? '',
      cusEmail: json['cus_email'] ?? '',
      merchantName: json['merchant_name'] ?? '',
    );
  }
}
