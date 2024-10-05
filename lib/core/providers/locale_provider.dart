import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localeProvider =
    NotifierProvider<LocaleNotifier, Locale>(LocaleNotifier.new);

class LocaleNotifier extends Notifier<Locale> {
  void setLocale(String languageCode) {
    state = Locale(languageCode);
  }

  void resetLocale() {
    state = const Locale('vi');
  }

  @override
  Locale build() {
    return const Locale('vi');
  }
}
