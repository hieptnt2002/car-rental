import 'package:car_rental/features/presentation/resources/route_manager.dart';
import 'package:car_rental/shared/data/remote/api_client.dart';
import 'package:car_rental/core/indicator/circle_indicator.dart';
import 'package:flutter/material.dart';

class UDialog {
  static bool _isLoading = false;

  static Future<void> showLoading([double opacity = 0.2]) async {
    _isLoading = true;
    await showDialog<void>(
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(opacity),
      context: Routes.rootNavigatorKey.currentState!.context,
      builder: (context) {
        return const PopScope(
          canPop: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitCircle(
                color: Colors.white,
              ),
            ],
          ),
        );
      },
    )
        .timeout(
          ApiClient.timeOut,
          onTimeout: popLoading,
        )
        .then((value) => _isLoading = true);
  }

  static Future<void> popLoading() async {
    if (_isLoading) {
      Routes.rootNavigatorKey.currentState?.pop();
    }
  }
}
