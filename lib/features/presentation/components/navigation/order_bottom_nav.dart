import 'package:car_rental/features/presentation/components/button/common_button.dart';
import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

class OrderBottomNav extends StatelessWidget {
  final String title;
  final String subTitle;
  final String titleAction;
  final VoidCallback? onPressed;
  const OrderBottomNav({
    super.key,
    required this.title,
    required this.subTitle,
    required this.titleAction,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kBottomNavigationBarHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subTitle,
                style: AppTextStyle.grayBodyXSmall,
              ),
              Text(
                title,
                style: AppTextStyle.w700SecondaryLabelLarge,
              ),
            ],
          ),
          CommonButton(
            title: titleAction,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
