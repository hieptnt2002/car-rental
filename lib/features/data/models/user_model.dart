import 'package:car_rental/features/data/datasources/_mappers/entity_convertable.dart';
import 'package:car_rental/features/domain/entities/user.dart';

class UserModel with EntityConvertable<UserModel, User> {
  final int id;
  final String email;
  final String? name;
  final String? image;
  final String? coverImage;
  final String? address;
  final String? phone;
  UserModel({
    required this.id,
    required this.email,
    this.name,
    this.image,
    this.address,
    this.phone,
    this.coverImage,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      image: map['image'],
      address: map['address'],
      phone: map['phone'],
      coverImage: map['coverImage'],
    );
  }
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'image': image,
        'address': address,
        'phone': phone,
        'coverImage': coverImage,
      };
  @override
  User toEntity() {
    return User(
      id: id,
      email: email,
      name: name,
      image: image,
      address: address,
      phone: phone,
      coverImage: coverImage,
    );
  }
}
