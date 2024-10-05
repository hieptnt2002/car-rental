import 'package:car_rental/features/domain/entities/booking.dart';
import 'package:car_rental/features/presentation/screen/booking/booking_list/providers/states/booking_list_notifier.dart';
import 'package:car_rental/shared/presentations/data_state.dart';
import 'package:riverpod/riverpod.dart';

final bookingListProvider =
    NotifierProvider.autoDispose<BookingListNotifier, DataState<List<Booking>>>(
  BookingListNotifier.new,
);
