import 'package:car_rental/shared/domain/repositories/data_result.dart';
import 'package:car_rental/features/domain/entities/user.dart';

abstract class AuthRepository {
  Future<DataResult<User>> login({
    required String username,
    required String password,
  });
  Future<DataResult<void>> register({
    required String username,
    required String email,
    required String password,
  });
}
