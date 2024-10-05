import 'package:car_rental/features/presentation/resources/app_colors.dart';
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

  static void showNotificatonSnackBar(String title) {
    final snackBar = SnackBar(
      content: Text(title),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.gray500,
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
