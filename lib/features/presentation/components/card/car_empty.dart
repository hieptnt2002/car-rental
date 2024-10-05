import 'package:car_rental/features/presentation/resources/app_images.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CarEmpty extends StatelessWidget {
  const CarEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.cartEmpty,
          width: 150,
          height: 150,
        ),
        const SizedBox(height: 8),
        Text(
          AppLocalizations.of(context)!.notFoundItem,
          style: AppTextStyle.gray500LabelLarge,
        ),
      ],
    );
  }
}
