import 'package:car_rental/core/extensions/locale_extension.dart';
import 'package:car_rental/features/domain/entities/booking.dart';
import 'package:car_rental/features/presentation/components/button/common_button.dart';
import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_images.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

class PaymentListTile extends StatefulWidget {
  final PaymentMethod? paymentMethodSelected;
  const PaymentListTile({super.key, this.paymentMethodSelected});

  @override
  State<PaymentListTile> createState() => _PaymentListTileState();
}

class _PaymentListTileState extends State<PaymentListTile> {
  late PaymentMethod? _paymentMethod = widget.paymentMethodSelected;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Chọn phương thức thanh toán',
            style: AppTextStyle.w700TextColorHeadingXSmall,
          ),
        ),
        const SizedBox(height: 16),
        PaymentOptionTile(
          value: PaymentMethod.cashOnDelivery,
          assetImage: AppImages.cube,
          title: context.l10n.cashOnDelivery,
          selectedMethod: _paymentMethod,
          onChanged: (value) {
            setState(() {
              _paymentMethod = value;
            });
          },
        ),
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CommonButton(
            title: 'Xác nhận',
            onPressed: _paymentMethod == null
                ? null
                : () => Navigator.pop(context, _paymentMethod),
          ),
        ),
      ],
    );
  }
}

class PaymentOptionTile extends StatelessWidget {
  final PaymentMethod value;
  final String assetImage;
  final String title;
  final String? subTitle;
  final PaymentMethod? selectedMethod;
  final Function(PaymentMethod) onChanged;

  const PaymentOptionTile({
    Key? key,
    required this.value,
    required this.assetImage,
    required this.title,
    this.selectedMethod,
    required this.onChanged,
    this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile<PaymentMethod>(
      value: value,
      groupValue: selectedMethod,
      onChanged: (value) => onChanged(value!),
      title: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.gray200,
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.all(8),
            child: Image.asset(
              assetImage,
              width: 32,
              height: 32,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyle.w700TextColorSmall),
              if (subTitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subTitle!,
                  style: AppTextStyle.grayBodyXSmall,
                ),
              ],
            ],
          ),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      controlAffinity: ListTileControlAffinity.trailing,
    );
  }
}
