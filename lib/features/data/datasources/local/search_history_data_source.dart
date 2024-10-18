import 'package:car_rental/shared/data/local/hive_storage_service.dart';
import 'package:hive/hive.dart';

abstract class SearchHistoryDataSource {
  Future<void> addSearchKeyword({required String keyword});
  Future<List<String>?> fetchAllSearchKeywords();
  Future<void> removeSearchKeyword(String keyword);
  Future<void> clearAllSearchKeywords();
}

class SearchHistoryDataSourceImpl extends HiveStorageService
    implements SearchHistoryDataSource {
  Future<Box<String>> _getBox() async => Hive.isBoxOpen('searchHistory')
      ? Hive.box('searchHistory')
      : await Hive.openBox('searchHistory');

  @override
  Future<void> removeSearchKeyword(String keyword) async {
    final box = await _getBox();
    final key =
        box.keys.firstWhere((k) => box.get(k) == keyword, orElse: () => null);
    if (key != null) await box.delete(key);
  }

  @override
  Future<void> clearAllSearchKeywords() async => (await _getBox()).clear();

  @override
  Future<List<String>?> fetchAllSearchKeywords() async =>
      (await _getBox()).values.toList();

  @override
  Future<void> addSearchKeyword({required String keyword}) async {
    final box = await _getBox();
    if (!box.values.contains(keyword)) await box.add(keyword);
  }
}
