import 'package:car_rental/features/domain/entities/booking.dart';
import 'package:car_rental/features/domain/usecases/booking/get_bookings_by_status.dart';
import 'package:car_rental/features/providers.dart';
import 'package:car_rental/shared/presentations/base_notifier.dart';
import 'package:car_rental/shared/presentations/data_state.dart';

class BookingListNotifier extends BaseNotifier<DataState<List<Booking>>> {
  late final GetBookingsByStatus _getBookingsByStatus;
  @override
  DataState<List<Booking>> build() {
    _getBookingsByStatus = ref.watch(getBookingsByStatusProvider);
    getBookingsByStatus(BookingStatus.pending);
    return const DataState.initial();
  }

  Future<void> getBookingsByStatus(BookingStatus status) async {
    await executeTask(
      future: () => _getBookingsByStatus.execute(
        GetBookingsByStatusParam(status: status),
      ),
      onLoading: (isLoading) => state = const DataState.loading(),
      onSuccess: (data) {
        state = DataState.data(data);
      },
      onError: (e) => state = DataState.error(e.toString()),
    );
  }
}
