import 'package:car_rental/shared/data/local/hive_storage_service.dart';
import 'package:car_rental/core/constants/hive_keys.dart';
import 'package:car_rental/features/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken({required String token});
  Future<String?> getToken();
  Future<void> saveUser({required UserModel user});
  Future<UserModel?> getUser();
  Future<void> clearSession();
}

class AuthLocalDataSourceImpl extends HiveStorageService
    implements AuthLocalDataSource {
  static final AuthLocalDataSourceImpl _instance =
      AuthLocalDataSourceImpl._internal();

  AuthLocalDataSourceImpl._internal();

  factory AuthLocalDataSourceImpl() => _instance;

  @override
  Future<void> clearSession() => Future.wait([
        delete(key: HiveKeys.token, boxName: HiveKeys.tokenBox),
        delete(key: HiveKeys.user, boxName: HiveKeys.userBox),
      ]);

  @override
  Future<String?> getToken() async {
    final token = await load(key: HiveKeys.token, boxName: HiveKeys.tokenBox);
    return token;
  }

  @override
  Future<UserModel?> getUser() async {
    final user = await load(key: HiveKeys.user, boxName: HiveKeys.userBox);
    return user;
  }

  @override
  Future<void> saveToken({required String token}) =>
      save(key: HiveKeys.token, value: token, boxName: HiveKeys.tokenBox);

  @override
  Future<void> saveUser({required UserModel user}) =>
      save(key: HiveKeys.user, value: user, boxName: HiveKeys.userBox);
}
