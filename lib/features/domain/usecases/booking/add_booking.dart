import 'package:car_rental/core/usecase/usecase.dart';
import 'package:car_rental/features/domain/entities/booking.dart';
import 'package:car_rental/features/domain/repositories/booking_repository.dart';
import 'package:car_rental/shared/domain/repositories/data_result.dart';

class AddBookingUseCase extends UseCase<DataResult<void>, AddBookingParam> {
  final BookingRepository _bookingRepository;

  AddBookingUseCase({required BookingRepository bookingRepository})
      : _bookingRepository = bookingRepository;
  @override
  Future<DataResult<void>> execute(AddBookingParam params) =>
      _bookingRepository.createBooking(
        fromTime: params.fromTime,
        lastTime: params.lastTime,
        rentalDays: params.rentalDays,
        totalCost: params.totalCost,
        paymentMethod: params.paymentMethod,
        paymentStatus: params.paymentStatus,
        additionalNotes: params.additionalNotes,
        pickupMethod: params.pickupMethod,
        deliveryAddressId: params.deliveryAddressId,
        carId: params.carId,
      );
}

class AddBookingParam {
  final DateTime fromTime;
  final DateTime lastTime;
  final int rentalDays;
  final double totalCost;
  final PaymentMethod paymentMethod;
  final PaymentStatus paymentStatus;
  final String additionalNotes;
  final PickupMethod pickupMethod;
  final int deliveryAddressId;
  final int carId;

  AddBookingParam({
    required this.fromTime,
    required this.lastTime,
    required this.rentalDays,
    required this.totalCost,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.additionalNotes,
    required this.pickupMethod,
    required this.deliveryAddressId,
    required this.carId,
  });
}
