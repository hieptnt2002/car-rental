import 'package:car_rental/core/usecase/usecase.dart';
import 'package:car_rental/features/domain/entities/booking.dart';
import 'package:car_rental/features/domain/repositories/booking_repository.dart';
import 'package:car_rental/shared/domain/repositories/data_result.dart';

class GetBookingsByStatus
    extends UseCase<DataResult<List<Booking>>, GetBookingsByStatusParam> {
  final BookingRepository _bookingRepository;

  GetBookingsByStatus({required BookingRepository bookingRepository})
      : _bookingRepository = bookingRepository;
  @override
  Future<DataResult<List<Booking>>> execute(GetBookingsByStatusParam params) =>
      _bookingRepository.getBookingsByStatus(status: params.status);
}

class GetBookingsByStatusParam {
  final BookingStatus status;

  GetBookingsByStatusParam({required this.status});
}
