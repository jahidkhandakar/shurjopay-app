class User {
  final String customerName;
  final String accessToken;

  User({
    required this.customerName,
    required this.accessToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      customerName: json['user']?['name'] ?? '',
      accessToken: json['token'] ?? '',
    );
  }
}
