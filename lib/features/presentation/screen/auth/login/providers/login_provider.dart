import 'package:car_rental/features/presentation/screen/auth/login/providers/state/login_notifier.dart';
import 'package:car_rental/shared/presentations/data_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider =
    NotifierProvider.autoDispose<LoginNotifier, DataState>(LoginNotifier.new);
