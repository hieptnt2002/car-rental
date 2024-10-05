import 'package:car_rental/features/data/datasources/_mappers/entity_convertable.dart';
import 'package:car_rental/features/domain/entities/delivery_address.dart';

class DeliveryAddressModel
    with EntityConvertable<DeliveryAddressModel, DeliveryAddress> {
  final int id;
  final String recipientName;
  final String addressLine;
  final String city;
  final String postalCode;
  final String phone;
  final String country;
  final String state;
  final bool defaultFlag;
  final double? latitude;
  final double? longitude;

  DeliveryAddressModel({
    required this.id,
    required this.recipientName,
    required this.addressLine,
    required this.city,
    required this.postalCode,
    required this.phone,
    required this.country,
    required this.state,
    required this.defaultFlag,
    this.latitude,
    this.longitude,
  });

  factory DeliveryAddressModel.fromMap(Map<String, dynamic> map) {
    return DeliveryAddressModel(
      id: map['id'],
      recipientName: map['recipientName'],
      addressLine: map['addressLine'],
      city: map['city'],
      postalCode: map['postalCode'],
      phone: map['phone'],
      country: map['country'],
      state: map['state'],
      defaultFlag: map['defaultFlag'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'recipientName': recipientName,
      'addressLine': addressLine,
      'city': city,
      'postalCode': postalCode,
      'phone': phone,
      'country': country,
      'state': state,
      'defaultFlag': defaultFlag,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  DeliveryAddress toEntity() {
    return DeliveryAddress(
      id: id,
      recipientName: recipientName,
      addressLine: addressLine,
      city: city,
      postalCode: postalCode,
      phone: phone,
      country: country,
      state: state,
      defaultFlag: defaultFlag,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
