import 'package:car_rental/features/data/models/adapter/user_model_adapter.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageService {
  LocalStorageService._();
  static final _instance = LocalStorageService._();
  factory LocalStorageService() => _instance;

  Future<void> initialazed() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    _registerAdapter();
  }

  void _registerAdapter() {
    Hive.registerAdapter(UserModelAdapter());
  }
}
