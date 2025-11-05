class SubCategory {
  final int id;
  final int categoryId;
  final String name;
  final String logo;
  final String? icon;

  SubCategory({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.logo,
    this.icon,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
      icon: json['icon'], // icon is nullable
    );
  }
}
