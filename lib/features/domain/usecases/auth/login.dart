import 'package:car_rental/shared/domain/repositories/data_result.dart';
import 'package:car_rental/core/usecase/usecase.dart';
import 'package:car_rental/features/domain/entities/user.dart';
import 'package:car_rental/features/domain/repositories/auth_repository.dart';

class LoginUseCase extends UseCase<DataResult<User>, LoginParam> {
  final AuthRepository _authRepository;

  LoginUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;
  @override
  Future<DataResult<User>> execute(LoginParam params) => _authRepository.login(
        username: params.username,
        password: params.password,
      );
}

class LoginParam {
  final String username;
  final String password;

  LoginParam({required this.username, required this.password});
}
