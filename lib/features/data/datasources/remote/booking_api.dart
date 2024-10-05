import 'package:car_rental/core/extensions/format_date_time_extension.dart';
import 'package:car_rental/core/extensions/string_case_extension.dart';
import 'package:car_rental/features/data/models/booking_model.dart';
import 'package:car_rental/features/domain/entities/booking.dart';
import 'package:car_rental/shared/data/remote/api_client.dart';

abstract class BookingApi {
  Future<void> createBooking({
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
    required int userId,
  });
  Future<List<BookingModel>> fetchBookings();
  Future<List<BookingModel>> fetchBookingsByStatus({
    required BookingStatus status,
    required int userId,
  });
  Future<BookingModel> fetchBookingById({required int id});
  Future<void> updateBooking({
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
    required int userId,
  });
  Future<void> cancelBooking({required int id});
}

class BookingApiImpl implements BookingApi {
  @override
  Future<void> cancelBooking({required int id}) {
    throw UnimplementedError();
  }

  @override
  Future<void> createBooking({
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
    required int userId,
  }) async {
    final requestBody = {
      'fromTime': fromTime.format(),
      'lastTime': lastTime.format(),
      'rentalDays': rentalDays,
      'totalCost': totalCost,
      'paymentMethod': paymentMethod.name.toSnakeCase(),
      'paymentStatus': paymentStatus.name.toSnakeCase(),
      'status': BookingStatus.pending.name.toSnakeCase(),
      'additionalNotes': additionalNotes,
      'vehicleCondition': '',
      'deliveryAddressId': deliveryAddressId,
      'carId': carId,
      'pickupMethod': pickupMethod.name.toSnakeCase(),
      'userId': userId,
    };

    await ApiClient.request(
      httpMethod: HttpMethod.post,
      url: '/booking',
      body: requestBody,
    );
  }

  @override
  Future<BookingModel> fetchBookingById({required int id}) {
    throw UnimplementedError();
  }

  @override
  Future<List<BookingModel>> fetchBookings() {
    throw UnimplementedError();
  }

  @override
  Future<void> updateBooking({
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
    required int userId,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<List<BookingModel>> fetchBookingsByStatus({
    required BookingStatus status,
    required int userId,
  }) async {
    final res = await ApiClient.request(
      httpMethod: HttpMethod.get,
      url: '/booking/by-status',
      queryParameters: {
        'status': status.name.toSnakeCase(),
        'userId': '$userId',
      },
    );
    return (res.data as List)
        .map((e) => BookingModel.fromMap(e as Map<String, dynamic>))
        .toList();
  }
}
