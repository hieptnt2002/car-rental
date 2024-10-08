import 'package:car_rental/shared/domain/repositories/base_repository.dart';
import 'package:car_rental/shared/domain/repositories/data_result.dart';
import 'package:car_rental/features/data/datasources/data_sources.dart';
import 'package:car_rental/features/data/datasources/local/auth_local_data_source.dart';
import 'package:car_rental/features/domain/entities/user.dart';
import 'package:car_rental/features/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  final AuthApi _authApi;
  final AuthLocalDataSource _authLocalDataSource;

  AuthRepositoryImpl({
    required AuthApi authApi,
    required AuthLocalDataSource authLocalDataSource,
  })  : _authApi = authApi,
        _authLocalDataSource = authLocalDataSource;
  @override
  Future<DataResult<User>> login({
    required String username,
    required String password,
  }) async {
    return await resultWithMappedFuture(
      future: () async {
        final userToken =
            await _authApi.loginUser(username: username, password: password);
        // save user & token local
        await Future.wait([
          _authLocalDataSource.saveToken(token: userToken.token),
          _authLocalDataSource.saveUser(user: userToken.user),
        ]);
        return userToken;
      },
      mapper: (userToken) => userToken.user.toEntity(),
    );
  }

  @override
  Future<DataResult<void>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    return await resultWithFuture(
      future: () => _authApi.registerUser(
        username: username,
        email: email,
        password: password,
      ),
    );
  }
}
