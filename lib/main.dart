import 'package:car_rental/app.dart';
import 'package:car_rental/config/flavor.dart';
import 'package:car_rental/observers.dart';
import 'package:car_rental/shared/data/local/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService().initialazed();
  await Flavor.settings();
  runApp(
    ProviderScope(
      observers: [Observers()],
      child: const MyApp(),
    ),
  );
}
