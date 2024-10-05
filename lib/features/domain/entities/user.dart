class User {
  final int id;
  final String email;
  final String? name;
  final String? image;
  final String? coverImage;
  final String? address;
  final String? phone;
  User({
    required this.id,
    required this.email,
    this.name,
    this.image,
    this.address,
    this.phone,
    this.coverImage,
  });
}
