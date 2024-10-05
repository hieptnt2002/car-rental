import 'package:car_rental/features/presentation/screen/auth/register/providers/state/register_notifier.dart';
import 'package:car_rental/shared/presentations/data_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerProvider =
    NotifierProvider.autoDispose<RegisterNotifier, DataState>(
  RegisterNotifier.new,
);
