import 'package:car_rental/features/presentation/screen/search/providers/state/search_notifier.dart';
import 'package:car_rental/features/presentation/screen/search/providers/state/search_results_notifier.dart';
import 'package:car_rental/features/presentation/screen/search/providers/state/search_results_state.dart';
import 'package:car_rental/features/presentation/screen/search/providers/state/search_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchProvider =
    NotifierProvider.autoDispose<SearchNotifier, SearchState>(
  SearchNotifier.new,
);

final searchResultsProvider =
    NotifierProvider.autoDispose<SearchResultsNotifier, SearchResultsState>(
  SearchResultsNotifier.new,
);
