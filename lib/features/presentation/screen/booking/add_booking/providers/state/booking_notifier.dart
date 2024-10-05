import 'package:car_rental/features/domain/entities/booking.dart';
import 'package:car_rental/features/domain/entities/car.dart';
import 'package:car_rental/features/domain/entities/delivery_address.dart';
import 'package:car_rental/features/domain/usecases/booking/add_booking.dart';
import 'package:car_rental/features/domain/usecases/delivery_address.dart/fetch_delivery_address_default.dart';
import 'package:car_rental/features/domain/usecases/delivery_address.dart/fetch_delivery_addresses.dart';
import 'package:car_rental/features/presentation/screen/booking/add_booking/providers/state/booking_state.dart';
import 'package:car_rental/features/providers.dart';
import 'package:car_rental/shared/domain/repositories/data_result.dart';
import 'package:car_rental/shared/presentations/base_notifier.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final deliverAddressesProvider = FutureProvider<List<DeliveryAddress>>(
  (ref) async {
    final result = await ref.read(fetchDeliveryAddressesProvider).execute(
          DeliveryAddressParam(userId: 1),
        );
    return switch (result) {
      Success() => result.data,
      Error() => throw result.exception!,
    };
  },
);

class BookingNotifier extends BaseNotifier<BookingState> {
  late final FetchDeliveryAddressDefault _deliveryAddressesDefaultUseCase;
  late final AddBookingUseCase _addBookingUseCase;
  @override
  BookingState build() {
    _deliveryAddressesDefaultUseCase =
        ref.watch(fetchDeliveryAddressDefaultProvider);
    _addBookingUseCase = ref.watch(addBookingProvider);
    fetchDeliveryAddressDefault();
    return BookingState();
  }

  Future<void> createBooking({
    required int carId,
    required VoidCallback onSuccess,
  }) async {
    final params = AddBookingParam(
      fromTime: state.fromTime!,
      lastTime: state.lastTime!,
      rentalDays: state.rentalDays,
      totalCost: state.totalCost,
      paymentMethod: state.paymentMethod!,
      paymentStatus: state.paymentStatus,
      additionalNotes: state.additionalNotes ?? '',
      pickupMethod: state.pickupMethod!,
      deliveryAddressId: state.deliveryAddress!.id,
      carId: carId,
    );
    await executeTask(
      future: () => _addBookingUseCase.execute(params),
      showLoadingOverlay: true,
      onSuccess: (data) {
        onSuccess();
      },
    );
  }

  Future<void> fetchDeliveryAddressDefault() async {
    final res = await _deliveryAddressesDefaultUseCase.execute(
      DeliveryAddressParam(userId: 1),
    );
    switch (res) {
      case Success<DeliveryAddress?>():
        state = state.copyWith(deliveryAddress: res.data);
      case Error<DeliveryAddress?>():
        break;
    }
  }

  void calculateRentalDays() {
    if (state.lastTime != null && state.fromTime != null) {
      final int days =
          (state.lastTime!.difference(state.fromTime!).inHours / 24).ceil();
      state = state.copyWith(rentalDays: days);
    }
  }

  double totalPayment(Car car) {
    return car.pricePerDay * (state.rentalDays);
  }

  bool isBookingStateValidation() {
    return state.fromTime != null &&
        state.lastTime != null &&
        state.deliveryAddress != null &&
        state.paymentMethod != null;
  }

  void setRentalPeriod([
    DateTime? fromTime,
    DateTime? lastTime,
    double price = 0,
  ]) {
    final int days = (lastTime!.difference(fromTime!).inHours / 24).ceil();

    state = state.copyWith(
      fromTime: fromTime,
      lastTime: lastTime,
      rentalDays: days,
      totalCost: days * price,
    );
  }

  void setPaymentMethod(PaymentMethod? paymentMethod) {
    state = state.copyWith(paymentMethod: paymentMethod);
  }

  void setDeliveryAddress(DeliveryAddress? deliveryAddress) {
    state = state.copyWith(deliveryAddress: deliveryAddress);
  }
}
