import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

class USnackBar {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static void showErrorSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.red500,
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showSuccessSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: AppColors.green500,
      behavior: SnackBarBehavior.floating,
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showInfoSnackBar(String title) {
    final snackBar = SnackBar(
      content: Text(
        title,
        style: AppTextStyle.primaryLabelSmall,
        textAlign: TextAlign.center,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBottomNavigationBarHeight),
      ),
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
