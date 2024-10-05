import 'package:flutter/material.dart';

extension Dimension on BuildContext {
  double get screenWidth {
    return MediaQuery.sizeOf(this).width;
  }

  double get screenHeight {
    return MediaQuery.sizeOf(this).height;
  }

  double percentWidth(double percent) {
    return screenWidth * (percent / 100);
  }

  double percentHeight(double percent) {
    return screenHeight * (percent / 100);
  }
}
