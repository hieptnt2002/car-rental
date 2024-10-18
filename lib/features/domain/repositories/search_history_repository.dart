import 'package:car_rental/shared/domain/repositories/data_result.dart';

abstract class SearchHistoryRepository {
  Future<void> addSearchKeyword({required String keyword});
  Future<DataResult<List<String>?>> getAllSearchHistory();
  Future<void> removeSearchKeyword(String keyword);
  Future<void> clearAllSearchHistory();
}
