import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

enum ButtonType { primary, secondary }

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final ButtonType type;
  final Widget? leading;
  const CommonButton({
    super.key,
    required this.title,
    this.onPressed,
    this.type = ButtonType.primary,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _getBackgroundColorButton(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        foregroundColor: AppColors.gray200,
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
            style: AppTextStyle.whiteLabelSmall,
          ),
        ],
      ),
    );
  }

  Color _getBackgroundColorButton() {
    switch (type) {
      case ButtonType.primary:
        return AppColors.primary;
      case ButtonType.secondary:
        return AppColors.gray400;
    }
  }
}
