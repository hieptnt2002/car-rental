import 'package:car_rental/features/presentation/screen/booking/add_booking/providers/state/booking_notifier.dart';
import 'package:car_rental/features/presentation/screen/booking/add_booking/providers/state/booking_state.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookingProvider =
    NotifierProvider.autoDispose<BookingNotifier, BookingState>(
  BookingNotifier.new,
);
