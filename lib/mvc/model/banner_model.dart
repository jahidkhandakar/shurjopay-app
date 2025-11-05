class PromotionalBanner {
  final int id;
  final String title;
  final String imageUrl;
  final String? redirectUrl;

  PromotionalBanner({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.redirectUrl,
  });

  factory PromotionalBanner.fromJson(Map<String, dynamic> json) {
    return PromotionalBanner(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image_url'],
      redirectUrl: json['redirect_url'],
    );
  }
}
