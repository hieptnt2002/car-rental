import 'package:car_rental/shared/data/remote/api_client.dart';
import 'package:car_rental/core/utils/utils.dart';
import 'package:car_rental/features/data/models/user_token_response.dart';

abstract class AuthApi {
  Future<UserTokenResponse> loginUser({
    required String username,
    required String password,
  });
  Future<void> registerUser({
    required String username,
    required String email,
    required String password,
  });
}

class AuthApiImpl implements AuthApi {
  @override
  Future<UserTokenResponse> loginUser({
    required String username,
    required String password,
  }) async {
    try {
      final res = await ApiClient.request(
        httpMethod: HttpMethod.post,
        url: '/auth/sign-in',
        body: {
          'username': username,
          'password': password,
          'deviceToken': await Utils.getDeviceId(),
        },
      );
      return UserTokenResponse.fromMap(res.data);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> registerUser({
    required String username,
    required String email,
    required String password,
  }) =>
      ApiClient.request(
        httpMethod: HttpMethod.post,
        url: '/auth/sign-up',
        body: {
          'name': username,
          'email': email,
          'password': password,
        },
      );
}
