import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental/core/extensions/currency_extension.dart';
import 'package:car_rental/core/extensions/format_date_time_extension.dart';
import 'package:car_rental/core/extensions/locale_extension.dart';
import 'package:car_rental/core/providers/locale_provider.dart';
import 'package:car_rental/features/domain/entities/booking.dart';
import 'package:car_rental/features/domain/entities/car.dart';
import 'package:car_rental/features/presentation/components/button/common_button.dart';
import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_svgs.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:car_rental/features/presentation/resources/route_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class BookingReviewScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> data;
  const BookingReviewScreen({super.key, required this.data});

  @override
  ConsumerState<BookingReviewScreen> createState() =>
      _BookingReviewScreenState();
}

class _BookingReviewScreenState extends ConsumerState<BookingReviewScreen> {
  Car get _car => widget.data['car'];
  double get _totalPayment => widget.data['totalCost'];
  DateTime get _fromTime => widget.data['fromTime'];
  DateTime get _lastTime => widget.data['lastTime'];
  String _paymenMethod() {
    switch (widget.data['paymentMethod'] as PaymentMethod) {
      case PaymentMethod.banking:
        return '';
      case PaymentMethod.wallet:
        return '';
      case PaymentMethod.cashOnDelivery:
        return context.l10n.cashOnDelivery;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: AppColors.green500,
                height: 500,
                child: SafeArea(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Center(
                            child: Lottie.asset(
                              'assets/lottie/verify.json',
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                              frameRate: const FrameRate(60),
                              repeat: true,
                              animate: true,
                            ),
                          ),
                          Positioned(
                            top: 16,
                            right: 16,
                            child: CloseButton(
                              color: AppColors.white,
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  Routes.home,
                                  (route) => false,
                                );
                              },
                              style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.black26),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        context.l10n.carBooked,
                        style: AppTextStyle.whiteHeadingSmall,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${context.l10n.totalPayment} : ${_totalPayment.formatCurrency(ref.watch(localeProvider))}',
                        style: AppTextStyle.whiteLabelLarge,
                      ),
                      const SizedBox(height: 24),
                      _buildCarInfo(context),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(16),
                color: AppColors.gray300,
                child: Text(
                  context.l10n.priceDetails,
                  style: AppTextStyle.w700TextColorLabelLarge,
                ),
              ),
              const SizedBox(height: 16),
              _buildPriceSummary(
                label: context.l10n.price,
                value:
                    '${_car.pricePerDay.formatCurrency(ref.watch(localeProvider))}/${context.l10n.day}',
              ),
              const SizedBox(height: 16),
              _buildPriceSummary(
                label: context.l10n.from,
                value: _fromTime.format(),
              ),
              const SizedBox(height: 16),
              _buildPriceSummary(
                label: context.l10n.to,
                value: _lastTime.format(),
              ),
              const SizedBox(height: 16),
              _buildPriceSummary(
                label: context.l10n.paymentMethod,
                value: _paymenMethod(),
              ),
              _divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.l10n.totalPayment,
                      style: AppTextStyle.w700TextColorSmall,
                    ),
                    Text(
                      _totalPayment.formatCurrency(ref.watch(localeProvider)),
                      style: AppTextStyle.w700SecondarySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildReturnHomeButton(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReturnHomeButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CommonButton(
        title: context.l10n.goBackToHome,
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.home,
            (route) => false,
          );
        },
        leading: SvgPicture.asset(
          AppSvgs.home,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
        ),
      ),
    );
  }

  Widget _divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        height: 32,
        thickness: 1,
        color: AppColors.gray300,
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
          style: AppTextStyle.whiteBodyXSmall,
        ),
        Expanded(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.clip,
            textAlign: TextAlign.right,
            style: isImportant
                ? AppTextStyle.w700WhiteLabelXSmall
                : AppTextStyle.w700SecondaryLabelXSmall,
          ),
        ),
      ],
    );
  }

  Widget _buildCarInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: _car.image,
            height: 120,
            width: 120,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Container(
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

  Widget _buildPriceSummary({
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyle.grayBodyXSmall),
          Text(value, style: AppTextStyle.w700TextColorSmall),
        ],
      ),
    );
  }
}
