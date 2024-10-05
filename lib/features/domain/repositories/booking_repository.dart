import 'package:car_rental/features/domain/entities/booking.dart';
import 'package:car_rental/shared/domain/repositories/data_result.dart';

abstract class BookingRepository {
  Future<DataResult<void>> createBooking({
    required DateTime fromTime,
    required DateTime lastTime,
    required int rentalDays,
    required double totalCost,
    required PaymentMethod paymentMethod,
    required PaymentStatus paymentStatus,
    required String additionalNotes,
    required PickupMethod pickupMethod,
    required int deliveryAddressId,
    required int carId,
  });
  Future<DataResult<List<Booking>>> fetchBookings();
  Future<DataResult<Booking>> fetchBookingById({required int id});
  Future<DataResult<void>> updateBooking({
    required int id,
    required DateTime fromTime,
    required DateTime lastTime,
    required int rentalDays,
    required double totalCost,
    required PaymentMethod paymentMethod,
    required PaymentStatus paymentStatus,
    required String additionalNotes,
    required PickupMethod pickupMethod,
    required int deliveryAddressId,
    required int carId,
  });
  Future<DataResult<void>> cancelBooking({required int id});
  Future<DataResult<List<Booking>>> getBookingsByStatus({
    required BookingStatus status,
  });
}
