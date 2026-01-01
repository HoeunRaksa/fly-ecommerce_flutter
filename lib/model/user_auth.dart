class User {
  final String id;
  final String name;
  final String email;
  final bool isVerified;
  final String? profileImage; // nullable
  final String role;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.isVerified,
    this.profileImage,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      isVerified: json['email_verified_at'] != null,
      profileImage: json['profile_image'], // may be null
      role: json['role'] ?? 'user',
    );
  }
}
