import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

enum OutlineButtonType { primary, secondary, warning }

class CommonOutlineButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final OutlineButtonType type;
  final Widget? leading;
  const CommonOutlineButton({
    super.key,
    required this.title,
    this.onPressed,
    this.type = OutlineButtonType.primary,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: AppColors.textColor),
        ),
        foregroundColor: AppColors.black,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        fixedSize: const Size.fromHeight(42.0),
        shadowColor: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leading != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: leading,
            ),
          Text(
            title,
            style: _getTextStyleButton(),
          ),
        ],
      ),
    );
  }

  TextStyle _getTextStyleButton() {
    switch (type) {
      case OutlineButtonType.primary:
        return AppTextStyle.secondaryLabelSmall;
      case OutlineButtonType.secondary:
        return AppTextStyle.textColorLabelSmall;
      case OutlineButtonType.warning:
        return AppTextStyle.redLabelSmall;
    }
  }
}
