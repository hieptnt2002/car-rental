import 'package:car_rental/features/domain/entities/car.dart';
import 'package:car_rental/features/domain/entities/delivery_address.dart';

enum BookingStatus { pending, renting, completed, cancelled }

enum PickupMethod {
  pickupAtDistributor,
  deliveryToHome;
}

enum PaymentMethod { cashOnDelivery, banking, wallet }

enum PaymentStatus { paid, unpaid }

class Booking {
  final int id;
  final String code;
  final DateTime fromTime;
  final DateTime lastTime;
  final int retalDays;
  final double totalCost;
  final BookingStatus status;
  final PaymentMethod paymentMethod;
  final PaymentStatus paymentStatus;
  final String additionalNotes;
  final DeliveryAddress deliveryAddress;
  final Car car;
  final PickupMethod pickupMethod;
  Booking({
    required this.id,
    required this.code,
    required this.fromTime,
    required this.lastTime,
    required this.retalDays,
    required this.totalCost,
    required this.status,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.additionalNotes,
    required this.pickupMethod,
    required this.deliveryAddress,
    required this.car,
  });
}
