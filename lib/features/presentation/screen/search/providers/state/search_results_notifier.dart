import 'package:car_rental/features/domain/usecases/car/get_cars_with_keyword_and_sorting.dart';
import 'package:car_rental/features/presentation/screen/search/providers/state/search_results_state.dart';
import 'package:car_rental/features/providers.dart';
import 'package:car_rental/shared/presentations/base_notifier.dart';
import 'package:car_rental/shared/presentations/data_state.dart';

class SearchResultsNotifier extends BaseNotifier<SearchResultsState> {
  late final GetCarsWithKeywordAndSorting _getCarsWithKeywordAndSorting;

  @override
  SearchResultsState build() {
    _getCarsWithKeywordAndSorting =
        ref.watch(getCarsWithKeywordAndSortingProvider);
    return SearchResultsState();
  }

  void toggleTab(int tabIndex, String keyword) {
    if (state.activeTab == 3 && state.activeTab == tabIndex) {
      state = state.copyWith(
        priceSortingDirection:
            isPriceSortingAscending ? SortDirection.desc : SortDirection.asc,
      );
    }
    if (state.activeTab != tabIndex || state.activeTab == 3) {
      final sortParams = _getSortParams(tabIndex);
      searchAndSortCars(
        keyword: keyword,
        sortBy: sortParams['sortBy'],
        sortDirection: sortParams['sortDirection'],
      );
      state = state.copyWith(activeTab: tabIndex);
    }
  }

  Map<String, dynamic> _getSortParams(int tabIndex) {
    final sortOptions = [
      {'sortBy': null, 'sortDirection': null},
      {'sortBy': 'updatedAt', 'sortDirection': SortDirection.desc},
      {'sortBy': 'mostBooked', 'sortDirection': null},
      {'sortBy': 'pricePerDay', 'sortDirection': state.priceSortingDirection},
    ];
    return sortOptions[tabIndex];
  }

  Future<void> searchAndSortCars({
    required String keyword,
    String? sortBy,
    SortDirection? sortDirection,
    bool isLoadingMore = false,
  }) async {
    if (!isLoadingMore) {
      state = state.copyWith(
        stateCars: const DataState.loading(),
        hasLoadingMore: false,
        searchKeyword: keyword,
        sortBy: sortBy,
        currentPage: 1,
        sortDirection: sortDirection,
      );
    }

    await executeTask(
      future: () => _getCarsWithKeywordAndSorting.execute(
        CarsWithKeywordAndSortingParam(
          pageNo: state.currentPage,
          pageSize: 10,
          keyword: keyword,
          sortBy: sortBy,
          sortDirection: sortDirection?.name,
        ),
      ),
      onSuccess: (paginatedCars) {
        state = state.copyWith(
          stateCars: DataState.data([
            ...state.stateCars.value ?? [],
            ...paginatedCars.data,
          ]),
          hasLoadingMore: false,
          totalPages: paginatedCars.totalPage,
        );
      },
    );
  }

  bool get isPriceSortingAscending =>
      state.priceSortingDirection == SortDirection.asc;

  Future<void> loadMoreCars() async {
    if (state.hasLoadingMore) return;
    state = state.copyWith(hasLoadingMore: true);
    if (state.currentPage < state.totalPages) {
      state = state.copyWith(currentPage: state.currentPage + 1);
      if (state.searchKeyword != null) {
        await searchAndSortCars(
          keyword: state.searchKeyword!,
          sortBy: state.sortBy,
          sortDirection: state.sortDirection,
          isLoadingMore: true,
        );
      }
    } else {
      await Future.delayed(const Duration(milliseconds: 500), () {
        state = state.copyWith(hasLoadingMore: false);
      });
    }
  }
}
