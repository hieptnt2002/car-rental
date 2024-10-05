import 'package:car_rental/core/extensions/currency_extension.dart';
import 'package:car_rental/core/extensions/format_date_time_extension.dart';
import 'package:car_rental/core/extensions/locale_extension.dart';
import 'package:car_rental/core/extensions/string_case_extension.dart';
import 'package:car_rental/core/providers/locale_provider.dart';
import 'package:car_rental/features/domain/entities/booking.dart';
import 'package:car_rental/features/presentation/components/button/common_button.dart';
import 'package:car_rental/features/presentation/components/button/common_outline_button.dart';
import 'package:car_rental/features/presentation/components/button/common_text_button.dart';
import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_images.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:car_rental/features/presentation/screen/booking/widgets/booking_car_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingDetailsScreen extends ConsumerStatefulWidget {
  final Booking booking;
  const BookingDetailsScreen({super.key, required this.booking});

  @override
  ConsumerState<BookingDetailsScreen> createState() =>
      _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends ConsumerState<BookingDetailsScreen> {
  Booking get _booking => widget.booking;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.rentalInformation),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBannerHeaderByStatus(),
            _buildDeliveryAddress(),
            const Divider(thickness: 12, color: AppColors.gray200),
            const SizedBox(height: 12),
            _buildDistributor(),
            _divider(16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BookingCarItem(car: _booking.car),
            ),
            _divider(16),
            _buildPriceDetails(),
            _divider(16),
            _buildTotalPayment(),
            _divider(),
            _buildContactAndReviewsButton(),
            if (_booking.status == BookingStatus.pending ||
                _booking.status == BookingStatus.cancelled)
              _divider(),
            if (_booking.status == BookingStatus.pending)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: double.maxFinite,
                child: CommonTextButton(
                  title: context.l10n.cancel,
                  type: TextButtonType.warning,
                  onPressed: () {},
                ),
              ),
            if (_booking.status == BookingStatus.cancelled)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: double.maxFinite,
                child: CommonTextButton(
                  title: context.l10n.viewCancellationDetails,
                  type: TextButtonType.secondary,
                  onPressed: () {},
                ),
              ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _divider([double h = 0.0, double v = 0.0]) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: h, vertical: v),
      child: const Divider(
        thickness: 1,
        height: 24,
        color: AppColors.gray200,
      ),
    );
  }

  Widget _buildBannerHeaderByStatus() {
    switch (_booking.status) {
      case BookingStatus.pending:
        return _buildBannerHeader(
          title: context.l10n.pendingPayment,
          content: context.l10n.waitingForSystemConfirmation,
          imageIcon: AppImages.wallet,
        );
      case BookingStatus.renting:
        return _buildBannerHeader(
          title: context.l10n.rented,
          content: context.l10n.enjoyYourTrip,
          imageIcon: AppImages.bookingRenting,
        );
      case BookingStatus.completed:
        return _buildBannerHeader(
          title: context.l10n.completed,
          content: context.l10n.thankYouForUsingService,
          imageIcon: AppImages.bookingCompleted,
        );
      case BookingStatus.cancelled:
        return _buildBannerHeader(
          title: context.l10n.cancelled,
          content: context.l10n.detailsInCancellation,
          imageIcon: AppImages.bookingCancel,
        );
    }
  }

  Widget _buildBannerHeader({
    required String title,
    required String content,
    required String imageIcon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      color: AppColors.mintGreen,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.whiteLabelMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: AppTextStyle.whiteBodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Image.asset(
            imageIcon,
            width: 48,
            height: 48,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryAddress() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.location_on_sharp,
            color: AppColors.gray500,
            size: 24,
          ),
          const SizedBox(width: 8),
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
                  '${_booking.deliveryAddress.recipientName} | ${_booking.deliveryAddress.phone}',
                  style: AppTextStyle.grayBodySmall,
                  maxLines: 2,
                ),
                const SizedBox(height: 4),
                Text(
                  _booking.deliveryAddress.address,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  style: AppTextStyle.grayBodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _buildCopyClipboard(
            '${_booking.deliveryAddress.recipientName}\n${_booking.deliveryAddress.phone}\n${_booking.deliveryAddress.address}',
          ),
        ],
      ),
    );
  }

  Widget _buildCopyClipboard(String text) {
    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: text));
      },
      child: Text(
        context.l10n.copy,
        style: AppTextStyle.mintGreenLabelSmall,
      ),
    );
  }

  Widget _buildDistributor() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              _booking.car.owner.name,
              maxLines: 1,
              style: AppTextStyle.w700TextColorMedium,
            ),
          ),
          const SizedBox(width: 16),
          Row(
            children: [
              Text(
                _booking.code,
                style: AppTextStyle.textColorLabelMedium,
              ),
              const SizedBox(width: 4),
              _buildCopyClipboard(_booking.code),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTotalPayment() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.l10n.totalPayment,
                      style: AppTextStyle.textColorLabelMedium,
                    ),
                    Text(
                      widget.booking.totalCost
                          .formatCurrency(ref.watch(localeProvider)),
                      style: AppTextStyle.w700SecondaryMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: '${context.l10n.pleasePay} '),
                      TextSpan(
                        text: _booking.totalCost
                            .formatCurrency(ref.watch(localeProvider)),
                        style: AppTextStyle.w700SecondaryXSmall,
                      ),
                      TextSpan(
                        text: ' ${context.l10n.unponReceipt}',
                      ),
                    ],
                    style: AppTextStyle.grayBodyXSmall,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.priceDetails,
            style: AppTextStyle.textColorLabelMedium,
          ),
          const SizedBox(height: 8),
          _buildPriceSummary(
            label: context.l10n.price,
            value: _booking.car.pricePerDay
                .formatCurrency(ref.watch(localeProvider)),
          ),
          const SizedBox(height: 8),
          _buildPriceSummary(
            label: context.l10n.rentalPeriod,
            value: context.l10n.rentalDay(_booking.retalDays),
          ),
          const SizedBox(height: 8),
          _buildPriceSummary(
            label: context.l10n.from,
            value: _booking.fromTime.format(),
          ),
          const SizedBox(height: 8),
          _buildPriceSummary(
            label: context.l10n.to,
            value: _booking.lastTime.format(),
          ),
          const SizedBox(height: 8),
          _buildPriceSummary(
            label: context.l10n.paymentMethod,
            value: _booking.paymentMethod.name.toSnakeCase(),
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
        Text(value, style: AppTextStyle.textColorLabelXSmall),
      ],
    );
  }

  Widget _buildContactAndReviewsButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: CommonOutlineButton(
              title: context.l10n.contact,
              leading: Image.asset(
                AppImages.chat,
                width: 24,
                color: AppColors.secondary,
              ),
              onPressed: () {},
              type: OutlineButtonType.secondary,
            ),
          ),
          if (_booking.status == BookingStatus.completed)
            const SizedBox(width: 16),
          if (_booking.status == BookingStatus.completed)
            Expanded(
              child: CommonOutlineButton(
                title: context.l10n.reviews,
                leading: const Icon(
                  Icons.star_border_rounded,
                  size: 24,
                  color: AppColors.textColor,
                ),
                onPressed: () {},
                type: OutlineButtonType.secondary,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: kBottomNavigationBarHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: AppColors.gray300,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: _buildButtonAction(),
    );
  }

  Widget _buildButtonAction() {
    switch (_booking.status) {
      case BookingStatus.pending:
        return CommonButton(
          title: context.l10n.processing,
          type: ButtonType.secondary,
        );
      case BookingStatus.renting:
        return CommonButton(
          title: context.l10n.findDropOffLocation,
          onPressed: () {},
        );
      case BookingStatus.completed:
      case BookingStatus.cancelled:
        return CommonButton(
          title: context.l10n.rentAgain,
          onPressed: () {},
        );
    }
  }
}
