import 'package:equatable/equatable.dart';

class DeliveryAddress extends Equatable {
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

  const DeliveryAddress({
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

  String get address => '$addressLine, $city, $state';

  @override
  List<Object?> get props => [
        id,
        recipientName,
        addressLine,
        city,
        postalCode,
        phone,
        country,
        state,
        defaultFlag,
        latitude,
        longitude,
      ];
}
