class Profile {
  String name;
  String mobileNo;
  String email;
  String dateOfBirth;
  String profileImage;

  Profile({
    required this.name,
    required this.mobileNo,
    required this.email,
    required this.dateOfBirth,
    required this.profileImage,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'] ?? '',
      mobileNo: json['mobile_no'] ?? '',
      email: json['email'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      profileImage: json['profile_image'] ?? '',
    );
  }
}
