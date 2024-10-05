import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

enum TextButtonType { primary, secondary, warning, info }

class CommonTextButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final TextButtonType type;
  final Widget? leading;
  const CommonTextButton({
    super.key,
    required this.title,
    this.onPressed,
    this.type = TextButtonType.primary,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        foregroundColor: AppColors.black,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        fixedSize: const Size.fromHeight(42.0),
        shadowColor: Colors.transparent,
      ),
      child: Text(
        title,
        style: _getTextStyleButton(),
      ),
    );
  }

  TextStyle _getTextStyleButton() {
    switch (type) {
      case TextButtonType.primary:
        return AppTextStyle.primaryLabelSmall;
      case TextButtonType.secondary:
        return AppTextStyle.secondaryLabelSmall;
      case TextButtonType.warning:
        return AppTextStyle.redLabelSmall;
      case TextButtonType.info:
        return AppTextStyle.gray500LabelSmall;
    }
  }
}
