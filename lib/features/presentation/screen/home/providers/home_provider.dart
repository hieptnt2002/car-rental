import 'package:car_rental/features/presentation/screen/home/providers/state/home_notifier.dart';
import 'package:car_rental/features/presentation/screen/home/providers/state/home_state.dart';
import 'package:car_rental/shared/presentations/data_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider =
    NotifierProvider.autoDispose<HomeNotifier, DataState<HomeState>>(
  HomeNotifier.new,
);
