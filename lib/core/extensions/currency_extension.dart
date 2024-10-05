import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension CurrencyExtension on double {
  String formatCurrency([Locale? locale]) {
    return NumberFormat.currency(
      locale: locale?.languageCode,
      decimalDigits: 0,
      symbol: locale?.languageCode == 'en' ? '\$' : '₫',
    ).format(this);
  }
}
