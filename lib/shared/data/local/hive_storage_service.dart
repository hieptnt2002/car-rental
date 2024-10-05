import 'package:hive/hive.dart';

abstract class HiveStorageService {
  Future<Box> _initBox(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox(boxName);
    } else {
      return Hive.box(boxName);
    }
  }

  Future<dynamic> load({required String key, required String boxName}) async {
    final box = await _initBox(boxName);
    try {
      final result = box.get(key);
      return result;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> save({
    required String key,
    required dynamic value,
    required String boxName,
  }) async {
    final box = await _initBox(boxName);
    try {
      await box.put(key, value);
      return;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> delete({required String key, required String boxName}) async {
    final box = await _initBox(boxName);
    try {
      await box.delete(key);
      return;
    } catch (_) {
      rethrow;
    }
  }
}
