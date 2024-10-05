import 'package:car_rental/core/extensions/string_case_extension.dart';
import 'package:car_rental/features/data/datasources/_mappers/entity_convertable.dart';
import 'package:car_rental/features/data/models/car_model.dart';
import 'package:car_rental/features/data/models/delivery_address_model.dart';
import 'package:car_rental/features/domain/entities/booking.dart';

class BookingModel with EntityConvertable<BookingModel, Booking> {
  final int id;
  final String code;
  final DateTime fromTime;
  final DateTime lastTime;
  final int rentalDays;
  final double totalCost;
  final BookingStatus status;
  final PaymentMethod paymentMethod;
  final PaymentStatus paymentStatus;
  final String additionalNotes;
  final DeliveryAddressModel deliveryAddress;
  final PickupMethod pickupMethod;
  final CarModel car;
  BookingModel({
    required this.id,
    required this.code,
    required this.fromTime,
    required this.lastTime,
    required this.rentalDays,
    required this.totalCost,
    required this.status,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.additionalNotes,
    required this.pickupMethod,
    required this.deliveryAddress,
    required this.car,
  });

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'],
      code: map['code'],
      fromTime: DateTime.parse(map['fromTime']),
      lastTime: DateTime.parse(map['lastTime']),
      rentalDays: map['rentalDays'],
      totalCost: map['totalCost'],
      status:
          BookingStatus.values.byName((map['status'] as String).toCamelCase()),
      paymentMethod: PaymentMethod.values
          .byName((map['paymentMethod'] as String).toCamelCase()),
      paymentStatus: PaymentStatus.values
          .byName((map['paymentStatus'] as String).toCamelCase()),
      additionalNotes: map['additionalNotes'],
      pickupMethod: PickupMethod.values
          .byName((map['pickupMethod'] as String).toCamelCase()),
      deliveryAddress: DeliveryAddressModel.fromMap(map['deliveryAddress']),
      car: CarModel.fromMap(map['car']),
    );
  }

  @override
  Booking toEntity() {
    return Booking(
      id: id,
      code: code,
      fromTime: fromTime,
      lastTime: lastTime,
      retalDays: rentalDays,
      totalCost: totalCost,
      status: status,
      paymentMethod: paymentMethod,
      paymentStatus: paymentStatus,
      additionalNotes: additionalNotes,
      pickupMethod: pickupMethod,
      deliveryAddress: deliveryAddress.toEntity(),
      car: car.toEntity(),
    );
  }
}
