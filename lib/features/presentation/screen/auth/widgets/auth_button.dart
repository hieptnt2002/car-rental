import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

enum AuthButtonType { primary, secondary }

class AuthButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final AuthButtonType type;
  final Widget? leading;
  const AuthButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.type = AuthButtonType.primary,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _getBackgroundColorButton(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: _getBorder(),
        ),
        foregroundColor: AppColors.gray500,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        fixedSize: const Size.fromHeight(58),
        shadowColor: Colors.transparent,
        elevation: 0,
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

  Color _getBackgroundColorButton() {
    switch (type) {
      case AuthButtonType.primary:
        return AppColors.primary;
      case AuthButtonType.secondary:
        return AppColors.white;
    }
  }

  BorderSide _getBorder() {
    switch (type) {
      case AuthButtonType.primary:
        return BorderSide.none;
      case AuthButtonType.secondary:
        return const BorderSide(color: AppColors.gray200);
    }
  }

  TextStyle _getTextStyleButton() {
    switch (type) {
      case AuthButtonType.primary:
        return AppTextStyle.secondaryLabelLarge;
      case AuthButtonType.secondary:
        return AppTextStyle.textColorLabelLarge;
    }
  }
}
