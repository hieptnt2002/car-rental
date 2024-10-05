import 'package:car_rental/features/domain/entities/booking.dart';
import 'package:car_rental/features/domain/entities/delivery_address.dart';

class BookingState {
  final DateTime? fromTime;
  final DateTime? lastTime;
  final int rentalDays;
  final double totalCost;
  final PaymentMethod? paymentMethod;
  final PaymentStatus paymentStatus;
  final String? additionalNotes;
  final DeliveryAddress? deliveryAddress;
  final PickupMethod? pickupMethod;

  BookingState({
    this.fromTime,
    this.lastTime,
    this.rentalDays = 0,
    this.totalCost = 0,
    this.paymentMethod,
    this.paymentStatus = PaymentStatus.unpaid,
    this.additionalNotes,
    this.deliveryAddress,
    this.pickupMethod = PickupMethod.deliveryToHome,
  });

  BookingState copyWith({
    DateTime? fromTime,
    DateTime? lastTime,
    int? rentalDays,
    double? totalCost,
    PaymentMethod? paymentMethod,
    PaymentStatus? paymentStatus,
    String? additionalNotes,
    DeliveryAddress? deliveryAddress,
    PickupMethod? pickupMethod,
  }) {
    return BookingState(
      fromTime: fromTime ?? this.fromTime,
      lastTime: lastTime ?? this.lastTime,
      rentalDays: rentalDays ?? this.rentalDays,
      totalCost: totalCost ?? this.totalCost,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      additionalNotes: additionalNotes ?? this.additionalNotes,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      pickupMethod: pickupMethod ?? this.pickupMethod,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fromTime': fromTime,
      'lastTime': lastTime,
      'rentalDays': rentalDays,
      'totalCost': totalCost,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'additionalNotes': additionalNotes,
      'deliveryAddress': deliveryAddress,
      'pickupMethod': pickupMethod,
    };
  }
}
