


class UserProfile {
  final String userId;
  final String name;
  final String email;
  final String phone;
  final String imageUrl;
  final bool isSeller;
  final String location;
  final String description;

  UserProfile({
    required this.userId,
    this.name = '',
    this.email = '',
    this.phone = '',
    this.imageUrl = '',
    this.isSeller = false,
    this.location = '',
    this.description = '',
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['user_id'] as String,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      isSeller: json['is_seller'] as bool? ?? false,
      location: json['location'] as String? ?? '',
      description: json['Description'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'email': email,
      'phone': phone,
      'image_url': imageUrl,
      'is_seller': isSeller,
      'location': location,
      'Description': description,
    };
  }
}
