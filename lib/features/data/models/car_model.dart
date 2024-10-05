import 'package:car_rental/features/data/datasources/_mappers/entity_convertable.dart';
import 'package:car_rental/features/data/models/brand_model.dart';
import 'package:car_rental/features/data/models/owner_model.dart';
import 'package:car_rental/features/data/models/review_model.dart';
import 'package:car_rental/features/domain/entities/car.dart';

class CarModel with EntityConvertable<CarModel, Car> {
  final int id;
  final String name;
  final String image;
  final double pricePerDay;
  final String color;
  final int seats;
  final double maxSpeed;
  final String fuelType;
  final double enginePower;
  final String descriptions;
  final AvailabilityStatus availabilityStatus;
  final TransmissionType transmissionType;
  final List<ReviewModel> reviews;
  final OwnerModel owner;
  final BrandModel brand;

  CarModel({
    required this.id,
    required this.name,
    required this.image,
    required this.pricePerDay,
    required this.color,
    required this.seats,
    required this.maxSpeed,
    required this.fuelType,
    required this.enginePower,
    required this.descriptions,
    required this.availabilityStatus,
    required this.transmissionType,
    required this.reviews,
    required this.owner,
    required this.brand,
  });
  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      pricePerDay: map['pricePerDay'],
      color: map['color'],
      seats: map['seats'],
      maxSpeed: map['maxSpeed'],
      fuelType: map['fuelType'],
      enginePower: map['enginePower'],
      descriptions: map['descriptions'],
      availabilityStatus:
          AvailabilityStatus.values.byName(map['availabilityStatus']),
      transmissionType: TransmissionType.values.byName(map['transmissionType']),
      reviews: (map['reviews'] as List<dynamic>)
          .map((e) => ReviewModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      owner: OwnerModel.fromMap(map['owner']),
      brand: BrandModel.fromMap(map['brand']),
    );
  }

  @override
  Car toEntity() {
    return Car(
      id: id,
      name: name,
      image: image,
      color: color,
      pricePerDay: pricePerDay,
      seats: seats,
      maxSpeed: maxSpeed,
      fuelType: fuelType,
      enginePower: enginePower,
      descriptions: descriptions,
      availabilityStatus: availabilityStatus,
      transmissionType: transmissionType,
      reviews: reviews.map((e) => e.toEntity()).toList(),
      brand: brand.toEntity(),
      owner: owner.toEntity(),
    );
  }
}
