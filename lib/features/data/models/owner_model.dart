import 'package:car_rental/features/data/datasources/_mappers/entity_convertable.dart';
import 'package:car_rental/features/domain/entities/owner.dart';

class OwnerModel with EntityConvertable<OwnerModel, Owner> {
  final int id;
  final String name;
  final String image;
  final String phone;
  final String email;
  final String descriptions;
  final String address;
  final double latitude;
  final double longitude;
  OwnerModel({
    required this.id,
    required this.name,
    required this.image,
    required this.phone,
    required this.email,
    required this.descriptions,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory OwnerModel.fromMap(Map<String, dynamic> map) {
    return OwnerModel(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      phone: map['phone'],
      email: map['email'],
      descriptions: map['descriptions'],
      address: map['address'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  @override
  Owner toEntity() {
    return Owner(
      id: id,
      name: name,
      image: image,
      phone: phone,
      email: email,
      descriptions: descriptions,
      address: address,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
