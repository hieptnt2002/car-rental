import 'package:car_rental/features/data/datasources/remote/booking_api.dart';
import 'package:car_rental/features/domain/entities/booking.dart';
import 'package:car_rental/features/domain/repositories/booking_repository.dart';
import 'package:car_rental/shared/domain/repositories/base_repository.dart';
import 'package:car_rental/shared/domain/repositories/data_result.dart';

class BookingRepositoryImpl extends BaseRepository
    implements BookingRepository {
  final BookingApi _bookingApi;

  BookingRepositoryImpl({required BookingApi bookingApi})
      : _bookingApi = bookingApi;
  @override
  Future<DataResult<void>> cancelBooking({required int id}) => resultWithFuture(
        future: () => _bookingApi.cancelBooking(id: id),
      );

  @override
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
  }) =>
      resultWithFuture(
        future: () => _bookingApi.createBooking(
          fromTime: fromTime,
          lastTime: lastTime,
          rentalDays: rentalDays,
          totalCost: totalCost,
          paymentMethod: paymentMethod,
          paymentStatus: paymentStatus,
          additionalNotes: additionalNotes,
          pickupMethod: pickupMethod,
          deliveryAddressId: deliveryAddressId,
          carId: carId,
          userId: 1,
        ),
      );

  @override
  Future<DataResult<Booking>> fetchBookingById({required int id}) =>
      resultWithMappedFuture(
        future: () => _bookingApi.fetchBookingById(id: id),
        mapper: (data) => data.toEntity(),
      );

  @override
  Future<DataResult<List<Booking>>> fetchBookings() {
    throw UnimplementedError();
  }

  @override
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
  }) {
    throw UnimplementedError();
  }

  @override
  Future<DataResult<List<Booking>>> getBookingsByStatus({
    required BookingStatus status,
  }) {
    return resultWithMappedFuture(
      future: () =>
          _bookingApi.fetchBookingsByStatus(status: status, userId: 1),
      mapper: (models) => models.map((e) => e.toEntity()).toList(),
    );
  }
}
