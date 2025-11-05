class Vendor {
  final int id;
  final String name;
  final String? logo;
  final String? vendorType;
  final int subCategoryId;
  final int categoryId;
  final String? websiteLink;

  Vendor({
    required this.id,
    required this.name,
    this.logo,
    this.vendorType,
    required this.subCategoryId,
    required this.categoryId,
    this.websiteLink,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      vendorType: json['vendor_type'],
      subCategoryId: json['sub_category_id'],
      categoryId: json['category_id'],
      websiteLink: json['website_link'],
    );
  }
}
