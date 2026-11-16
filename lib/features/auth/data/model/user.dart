class User {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String image;

  const User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      image: json['image'] as String? ?? '',
    );
  }

  String get fullName => '$firstName $lastName'.trim();
}