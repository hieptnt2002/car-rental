import 'package:car_rental/features/domain/entities/brand.dart';
import 'package:car_rental/features/domain/entities/owner.dart';
import 'package:car_rental/features/domain/entities/review.dart';

enum AvailabilityStatus { available, notAvailable, maintenance }

enum TransmissionType { manual, automatic }

class Car {
  final int id;
  final String name;
  final String image;
  final String color;
  final double pricePerDay;
  final int seats;
  final double maxSpeed;
  final String fuelType;
  final double enginePower;
  final String descriptions;
  final AvailabilityStatus availabilityStatus;
  final TransmissionType transmissionType;
  final List<Review> reviews;
  final Owner owner;
  final Brand brand;
  Car({
    required this.id,
    required this.name,
    required this.image,
    required this.color,
    required this.pricePerDay,
    required this.seats,
    required this.maxSpeed,
    required this.fuelType,
    required this.enginePower,
    required this.descriptions,
    required this.availabilityStatus,
    required this.transmissionType,
    required this.reviews,
    required this.brand,
    required this.owner,
  });
}
