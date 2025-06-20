class User {
  final String customerName;
  final String accessToken;
  final String tokenType;
  final int expiresIn;

  User({
    required this.customerName,
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      customerName: json['customer_name'],
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      expiresIn: json['expires_in'],
    );
  }
}
