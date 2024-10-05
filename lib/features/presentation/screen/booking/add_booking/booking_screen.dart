import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental/core/extensions/currency_extension.dart';
import 'package:car_rental/core/extensions/format_date_time_extension.dart';
import 'package:car_rental/core/extensions/locale_extension.dart';
import 'package:car_rental/core/providers/locale_provider.dart';
import 'package:car_rental/core/utils/bottom_sheet.dart';
import 'package:car_rental/features/domain/entities/booking.dart';
import 'package:car_rental/features/domain/entities/car.dart';
import 'package:car_rental/features/domain/entities/delivery_address.dart';
import 'package:car_rental/features/presentation/components/button/common_outline_button.dart';
import 'package:car_rental/features/presentation/components/navigation/order_bottom_nav.dart';
import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_images.dart';
import 'package:car_rental/features/presentation/resources/app_svgs.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:car_rental/features/presentation/resources/route_manager.dart';
import 'package:car_rental/features/presentation/screen/booking/add_booking/providers/booking_provider.dart';
import 'package:car_rental/features/presentation/screen/booking/add_booking/providers/state/booking_state.dart';
import 'package:car_rental/features/presentation/screen/booking/add_booking/widgets/booking_success_card.dart';
import 'package:car_rental/features/presentation/screen/booking/add_booking/widgets/payment_list_tile.dart';
import 'package:car_rental/features/presentation/screen/booking/add_booking/widgets/delivery_address_list_tile.dart';
import 'package:car_rental/features/presentation/screen/booking/add_booking/widgets/rental_period_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookingScreen extends ConsumerStatefulWidget {
  final Car car;

  const BookingScreen({super.key, required this.car});

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  Car get _car => widget.car;
  late final _bookingNotifier = ref.read(bookingProvider.notifier);
  late BookingState _bookingState;

  Future<void> _handleBooking() async {
    await _bookingNotifier.createBooking(
      carId: _car.id,
      onSuccess: _showBookingSuccessDialog,
    );
  }

  @override
  Widget build(BuildContext context) {
    _bookingState = ref.watch(bookingProvider);
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.bookACar)),
      bottomNavigationBar: OrderBottomNav(
        title:
            _bookingState.totalCost.formatCurrency(ref.watch(localeProvider)),
        subTitle: context.l10n.totalPayment,
        titleAction: context.l10n.bookNow,
        onPressed:
            _bookingNotifier.isBookingStateValidation() ? _handleBooking : null,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            _buildDeliveryAddressSection(),
            const SizedBox(height: 8),
            _buildCarInfoCard(),
            _divider(),
            _buildSectionTitle(context.l10n.rentalPeriod),
            _buildRentalPeriod(),
            _divider(),
            _buildSectionTitle(context.l10n.paymentMethod),
            _buildPaymentMethods(),
            _divider(),
            _buildSectionTitle(context.l10n.priceDetails),
            const SizedBox(height: 16),
            _buildTotalPriceSection(),
            const SizedBox(height: 16),
            _buildSecurityBanner(),
          ],
        ),
      ),
    );
  }

  void _showBookingSuccessDialog() {
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) {
        return const BookingSuccessCard();
      },
    ).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.bookingReview,
          (route) => false,
          arguments: {..._bookingState.toMap(), 'car': _car},
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: AppTextStyle.w700TextColorLabelLarge,
      ),
    );
  }

  Widget _buildSecurityBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.gray200,
      child: Row(
        children: [
          SvgPicture.asset(
            AppSvgs.shield,
            colorFilter:
                const ColorFilter.mode(AppColors.gray500, BlendMode.srcIn),
            width: 45,
            height: 45,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              context.l10n.contentBannerOder,
              style: AppTextStyle.textColorBodyXSmall,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider([double inset = 16]) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: inset),
      child: const Divider(
        height: 32,
        thickness: 1,
        color: AppColors.gray300,
      ),
    );
  }

  Widget _buildCarInfoCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.gray100,
            ),
            child: CachedNetworkImage(
              imageUrl: _car.image,
              height: 120,
              width: 120,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.gray100,
              ),
              height: 120,
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildInfoCarRow(label: 'Hãng xe', value: _car.brand.name),
                  const SizedBox(height: 4),
                  _buildInfoCarRow(label: 'Mẫu xe', value: _car.name),
                  const SizedBox(height: 4),
                  _buildInfoCarRow(
                    label: 'Số chỗ ngồi',
                    value: 'Xe ${_car.seats} chỗ',
                    isImportant: true,
                  ),
                  const SizedBox(height: 4),
                  _buildInfoCarRow(label: 'Màu sắc', value: _car.color),
                  const SizedBox(height: 4),
                  _buildInfoCarRow(
                    label: 'Giá thuê',
                    value:
                        '${_car.pricePerDay.formatCurrency(ref.watch(localeProvider))}/${context.l10n.day}',
                    isImportant: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCarRow({
    required String label,
    required String value,
    bool isImportant = false,
  }) {
    return Row(
      children: [
        Text(
          label,
          style: AppTextStyle.grayBodyXSmall,
        ),
        Expanded(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.clip,
            textAlign: TextAlign.right,
            style: isImportant
                ? AppTextStyle.w700TextColorLabelXSmall
                : AppTextStyle.w700SecondaryLabelXSmall,
          ),
        ),
      ],
    );
  }

  Widget _buildTotalPriceSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPriceSummary(
            label: context.l10n.price,
            value: _car.pricePerDay.formatCurrency(ref.watch(localeProvider)),
          ),
          const SizedBox(height: 16),
          _buildPriceSummary(
            label: context.l10n.rentalPeriod,
            value: context.l10n.rentalDay(_bookingState.rentalDays),
          ),
          _divider(0),
          _buildPriceSummary(
            label: context.l10n.totalAmount,
            value: _bookingNotifier
                .totalPayment(_car)
                .formatCurrency(ref.watch(localeProvider)),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSummary({
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyle.grayBodyXSmall),
        Text(value, style: AppTextStyle.w700TextColorSmall),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return ListTile(
      onTap: _showPaymentOptionsSheet,
      leading: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: AppColors.secondary,
        ),
        child: Image.asset(
          AppImages.cube,
          width: 24,
          color: Colors.white,
        ),
      ),
      title: const Text(
        'Chọn phương thức thanh toán',
        style: AppTextStyle.textColorLabelMedium,
      ),
      subtitle: Text(
        _bookingState.paymentMethod != null
            ? context.l10n.cashOnDelivery
            : 'Chưa có phương thức thanh toán',
        style: _bookingState.paymentMethod != null
            ? AppTextStyle.w700SecondaryXSmall
            : AppTextStyle.grayBodyXSmall,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: AppColors.textColor,
        size: 16,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  Widget _buildRentalPeriod() {
    return ListTile(
      onTap: _showRentalPeriodPickerSheet,
      leading: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: AppColors.secondary,
        ),
        child: Image.asset(
          AppImages.calendar,
          width: 24,
          color: Colors.white,
        ),
      ),
      title: const Text(
        'Chọn ngày khởi hành và kết thúc',
        style: AppTextStyle.textColorLabelMedium,
      ),
      subtitle: _bookingState.fromTime == null && _bookingState.lastTime == null
          ? const Text(
              'Chọn thời gian di chuyển',
              style: AppTextStyle.grayBodyXSmall,
            )
          : RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Từ ',
                    style: AppTextStyle.grayBodyXSmall,
                  ),
                  TextSpan(
                    text: _bookingState.fromTime!.format(),
                    style: AppTextStyle.w700SecondaryXSmall,
                  ),
                  const TextSpan(
                    text: ' đến ',
                    style: AppTextStyle.grayBodyXSmall,
                  ),
                  TextSpan(
                    text: _bookingState.lastTime!.format(),
                    style: AppTextStyle.w700SecondaryXSmall,
                  ),
                ],
              ),
            ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: AppColors.textColor,
        size: 16,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  Widget _buildDeliveryAddressSection() {
    return InkWell(
      onTap: _showDialogChooseDeliveryAddress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            if (_bookingState.deliveryAddress != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on_sharp,
                    color: AppColors.secondary,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Địa chỉ nhận xe',
                                style: AppTextStyle.textColorBodyMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${_bookingState.deliveryAddress!.recipientName} | ${_bookingState.deliveryAddress!.phone}',
                                style: AppTextStyle.textColorBodySmall,
                                maxLines: 2,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _bookingState.deliveryAddress!.address,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                                style: AppTextStyle.textColorBodySmall,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColors.gray500,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            else
              Column(
                children: [
                  Center(
                    child: Text(
                      context.l10n.pleaseSelectPickUpAddress,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.gray500LabelSmall,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CommonOutlineButton(
                    title: context.l10n.changeAddress,
                    onPressed: _showDialogChooseDeliveryAddress,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDialogChooseDeliveryAddress() async {
    final result = await UBottomSheet.showBottomSheet(
      builder: (_) => DeliveryAddressListTile(
        deliveryAddress: _bookingState.deliveryAddress,
      ),
    );
    if (mounted && result != null && result is DeliveryAddress) {
      _bookingNotifier.setDeliveryAddress(result);
    }
  }

  Future<void> _showRentalPeriodPickerSheet() async {
    final result = await UBottomSheet.showBottomSheet(
      builder: (_) => RentalPeriodPicker(
        fromTime: _bookingState.fromTime,
        lastTime: _bookingState.lastTime,
      ),
    );
    if (mounted && result != null && result is List<DateTime?>) {
      _bookingNotifier.setRentalPeriod(result[0], result[1], _car.pricePerDay);
    }
  }

  Future<void> _showPaymentOptionsSheet() async {
    final result = await UBottomSheet.showBottomSheet(
      builder: (_) => PaymentListTile(
        paymentMethodSelected: _bookingState.paymentMethod,
      ),
    );
    if (mounted && result is PaymentMethod?) {
      _bookingNotifier.setPaymentMethod(result);
    }
  }
}
