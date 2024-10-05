import 'package:car_rental/shared/presentations/base_notifier.dart';
import 'package:car_rental/shared/presentations/data_state.dart';
import 'package:car_rental/features/domain/usecases/auth/login.dart';
import 'package:car_rental/features/providers.dart';

class LoginNotifier extends BaseNotifier<DataState> {
  late final LoginUseCase _loginUseCase;

  @override
  DataState build() {
    _loginUseCase = ref.watch(loginProvider);
    return const DataState.initial();
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    await executeTask(
      future: () => _loginUseCase
          .execute(LoginParam(username: username, password: password)),
      showLoadingOverlay: true,
    );
  }
}
