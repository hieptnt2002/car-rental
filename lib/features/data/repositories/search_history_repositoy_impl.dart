import 'package:car_rental/features/data/datasources/local/search_history_data_source.dart';
import 'package:car_rental/features/domain/repositories/search_history_repository.dart';
import 'package:car_rental/shared/domain/repositories/base_repository.dart';
import 'package:car_rental/shared/domain/repositories/data_result.dart';

class SearchHistoryRepositoryImpl extends BaseRepository
    implements SearchHistoryRepository {
  final SearchHistoryDataSource _searchHistoryDataSource;

  SearchHistoryRepositoryImpl({
    required SearchHistoryDataSource searchHistoryDataSource,
  }) : _searchHistoryDataSource = searchHistoryDataSource;
  @override
  Future<void> clearAllSearchHistory() =>
      _searchHistoryDataSource.clearAllSearchKeywords();

  @override
  Future<void> removeSearchKeyword(String keyword) =>
      _searchHistoryDataSource.removeSearchKeyword(keyword);

  @override
  Future<DataResult<List<String>?>> getAllSearchHistory() => resultWithFuture(
        future: _searchHistoryDataSource.fetchAllSearchKeywords,
      );

  @override
  Future<void> addSearchKeyword({required String keyword}) =>
      _searchHistoryDataSource.addSearchKeyword(keyword: keyword);
}
