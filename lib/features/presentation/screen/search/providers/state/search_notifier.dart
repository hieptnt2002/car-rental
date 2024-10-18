import 'package:car_rental/features/domain/repositories/search_history_repository.dart';
import 'package:car_rental/features/domain/usecases/car/get_car_names.dart';
import 'package:car_rental/features/presentation/screen/search/providers/state/search_state.dart';
import 'package:car_rental/features/providers.dart';
import 'package:car_rental/shared/presentations/base_notifier.dart';

class SearchNotifier extends BaseNotifier<SearchState> {
  late final GetCarNames _getCarNamesUseCase;
  late final SearchHistoryRepository _searchHistoryRepository;
  @override
  SearchState build() {
    _getCarNamesUseCase = ref.watch(getCarNamesProvider);
    _searchHistoryRepository = ref.watch(searchHistoryRepositoryProvider);
    _getRecentSearches();
    return SearchState();
  }

  Future<void> getSuggestedSearches(String keyword) async {
    executeTask(
      future: () => _getCarNamesUseCase.execute(
        GetCarNamesParam(keyword: keyword),
      ),
      onSuccess: (data) {
        state = state.copyWith(suggestedSearches: data);
      },
    );
  }

  Future<void> _getRecentSearches() async {
    executeTask(
      future: () => _searchHistoryRepository.getAllSearchHistory(),
      onSuccess: (data) {
        state = state.copyWith(recentSearches: data);
      },
    );
  }

  Future<void> addSearchToHistory(String keyword) async {
    await _searchHistoryRepository.addSearchKeyword(keyword: keyword);
    _getRecentSearches();
  }

  Future<void> clearRecentSearches() async {
    await _searchHistoryRepository.clearAllSearchHistory();
    state = state.copyWith(recentSearches: []);
  }

  void clearSuggestions() {
    state = state.copyWith(suggestedSearches: []);
  }
}
