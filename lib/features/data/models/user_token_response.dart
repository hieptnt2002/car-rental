import 'package:car_rental/features/data/models/user_model.dart';

class UserTokenResponse {
  final String token;
  final UserModel user;
  UserTokenResponse({
    required this.token,
    required this.user,
  });

  factory UserTokenResponse.fromMap(Map<String, dynamic> map) {
    return UserTokenResponse(
      token: map['accessToken'],
      user: UserModel.fromMap(map['user']),
    );
  }
}
