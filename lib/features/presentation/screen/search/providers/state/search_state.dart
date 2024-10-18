class SearchState {
  final List<String> suggestedSearches;
  final List<String> recentSearches;

  SearchState({
    this.suggestedSearches = const [],
    this.recentSearches = const [],
  });

  SearchState copyWith({
    List<String>? suggestedSearches,
    List<String>? recentSearches,
  }) {
    return SearchState(
      suggestedSearches: suggestedSearches ?? this.suggestedSearches,
      recentSearches: recentSearches ?? this.recentSearches,
    );
  }
}
