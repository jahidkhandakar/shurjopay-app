import 'sub_category_model.dart';

class ServiceCategory {
  final int id;
  final String name;
  final List<SubCategory> subCategories;

  ServiceCategory({
    required this.id,
    required this.name,
    required this.subCategories,
  });

  factory ServiceCategory.fromJson(Map<String, dynamic> json) {
    final rawSubCategories = json['sub_categories'];

    final subs = (rawSubCategories is List)
        ? rawSubCategories.map((s) => SubCategory.fromJson(s)).toList()
        : <SubCategory>[]; // fallback to empty list if null or not a list

    return ServiceCategory(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      subCategories: subs,
    );
  }
}
