import 'package:car_rental/features/domain/entities/car.dart';
import 'package:car_rental/shared/presentations/data_state.dart';

enum SortDirection { asc, desc }

class SearchResultsState {
  final DataState<List<Car>> stateCars;
  final bool hasLoadingMore;
  int currentPage;
  String? sortBy;
  SortDirection? sortDirection;
  String? searchKeyword;
  int totalPages;
  SortDirection priceSortingDirection;
  int activeTab;

  SearchResultsState({
    this.stateCars = const DataState.initial(),
    this.hasLoadingMore = false,
    this.currentPage = 1,
    this.sortBy,
    this.sortDirection,
    this.searchKeyword,
    this.totalPages = 0,
    this.priceSortingDirection = SortDirection.asc,
    this.activeTab = 0,
  });

  SearchResultsState copyWith({
    DataState<List<Car>>? stateCars,
    bool? hasLoadingMore,
    int? currentPage,
    String? sortBy,
    SortDirection? sortDirection,
    String? searchKeyword,
    int? totalPages,
    SortDirection? priceSortingDirection,
    int? activeTab,
  }) {
    return SearchResultsState(
      stateCars: stateCars ?? this.stateCars,
      hasLoadingMore: hasLoadingMore ?? this.hasLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      sortBy: sortBy ?? this.sortBy,
      sortDirection: sortDirection ?? this.sortDirection,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      totalPages: totalPages ?? this.totalPages,
      priceSortingDirection:
          priceSortingDirection ?? this.priceSortingDirection,
      activeTab: activeTab ?? this.activeTab,
    );
  }
}
