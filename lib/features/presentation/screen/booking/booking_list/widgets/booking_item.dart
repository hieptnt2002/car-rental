import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental/core/extensions/currency_extension.dart';
import 'package:car_rental/core/extensions/format_date_time_extension.dart';
import 'package:car_rental/core/extensions/locale_extension.dart';
import 'package:car_rental/core/providers/locale_provider.dart';
import 'package:car_rental/features/domain/entities/booking.dart';
import 'package:car_rental/features/presentation/components/button/common_button.dart';
import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_svgs.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:car_rental/features/presentation/resources/route_manager.dart';
import 'package:car_rental/features/presentation/screen/booking/widgets/booking_car_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookingItem extends ConsumerStatefulWidget {
  final Booking booking;
  const BookingItem({super.key, required this.booking});

  @override
  ConsumerState<BookingItem> createState() => _BookingItemState();
}

class _BookingItemState extends ConsumerState<BookingItem> {
  Booking get _booking => widget.booking;
  String _getBookingStatus() {
    switch (widget.booking.status) {
      case BookingStatus.pending:
        return context.l10n.pending;
      case BookingStatus.renting:
        return context.l10n.rented;
      case BookingStatus.completed:
        return context.l10n.completed;
      case BookingStatus.cancelled:
        return context.l10n.cancelled;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.bookingDetails,
          arguments: {'booking': _booking},
        );
      },
      child: Container(
        color: AppColors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDistributorAndBookingStatus(),
            const SizedBox(height: 16),
            BookingCarItem(car: _booking.car),
            const SizedBox(height: 8),
            _buildPriceSummary(
              label: context.l10n.price,
              value: _booking.car.pricePerDay
                  .formatCurrency(ref.watch(localeProvider)),
            ),
            _buildPriceSummary(
              label: context.l10n.rentalPeriod,
              value: context.l10n.rentalDay(_booking.retalDays),
            ),
            _buildPriceSummary(
              label: context.l10n.from,
              value: _booking.fromTime.format(),
            ),
            _buildPriceSummary(
              label: context.l10n.to,
              value: _booking.lastTime.format(),
            ),
            _divider(),
            _buildTotalPrice(),
            _divider(),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 120,
                child: _buildButtonAction(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return const Divider(
      height: 32,
      thickness: 1,
      color: AppColors.gray200,
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

  Widget _buildTotalPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SvgPicture.asset(
          AppSvgs.payment,
          colorFilter: const ColorFilter.mode(
            AppColors.secondary,
            BlendMode.srcIn,
          ),
          width: 24,
        ),
        const SizedBox(width: 4),
        Text(
          '${context.l10n.totalPayment}:',
          style: AppTextStyle.grayBodySmall,
        ),
        const SizedBox(width: 4),
        Text(
          widget.booking.totalCost.formatCurrency(ref.watch(localeProvider)),
          style: AppTextStyle.w700SecondaryMedium,
        ),
      ],
    );
  }

  Widget _buildDistributorAndBookingStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: Container(
            color: AppColors.gray100,
            padding: const EdgeInsets.all(4),
            child: CachedNetworkImage(
              imageUrl: _booking.car.image,
              width: 32,
              height: 32,
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Text(
            _booking.car.owner.name,
            maxLines: 1,
            style: AppTextStyle.w700TextColorMedium,
          ),
        ),
        Text(
          _getBookingStatus(),
          style: AppTextStyle.secondaryBodyMedium,
        ),
      ],
    );
  }

  Widget _buildButtonAction() {
    switch (widget.booking.status) {
      case BookingStatus.pending:
        return CommonButton(
          title: context.l10n.processing,
          type: ButtonType.secondary,
        );
      case BookingStatus.renting:
        return CommonButton(
          title: context.l10n.processed,
          type: ButtonType.secondary,
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
