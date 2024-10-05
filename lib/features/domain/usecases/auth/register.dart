import 'package:car_rental/shared/domain/repositories/data_result.dart';
import 'package:car_rental/core/usecase/usecase.dart';
import 'package:car_rental/features/domain/repositories/auth_repository.dart';

class RegisterUseCase extends UseCase<DataResult<void>, RegisterParam> {
  final AuthRepository _authRepository;

  RegisterUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;
  @override
  Future<DataResult<void>> execute(RegisterParam params) =>
      _authRepository.register(
        username: params.username,
        email: params.email,
        password: params.password,
      );
}

class RegisterParam {
  final String username;
  final String email;
  final String password;

  RegisterParam({
    required this.username,
    required this.email,
    required this.password,
  });
}
