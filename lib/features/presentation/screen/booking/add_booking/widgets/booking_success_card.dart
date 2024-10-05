import 'package:car_rental/core/extensions/locale_extension.dart';
import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BookingSuccessCard extends StatelessWidget {
  const BookingSuccessCard({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Opacity(
        opacity: 0.2,
        child: Material(
          color: AppColors.green500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/lottie/verify.json',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
                frameRate: const FrameRate(60),
                repeat: false,
                animate: true,
              ),
              const SizedBox(height: 16),
              Text(
                context.l10n.thanksYou,
                style: AppTextStyle.whiteHeadingSmall,
              ),
              const SizedBox(height: 8),
              Text(
                context.l10n.carBooked,
                textAlign: TextAlign.center,
                style: AppTextStyle.whiteLabelSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
