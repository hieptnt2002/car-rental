import 'package:car_rental/shared/presentations/base_notifier.dart';
import 'package:car_rental/features/domain/usecases/auth/register.dart';
import 'package:car_rental/features/providers.dart';
import 'package:car_rental/shared/presentations/data_state.dart';

class RegisterNotifier extends BaseNotifier<DataState> {
  late final RegisterUseCase _registerUseCase;

  @override
  DataState build() {
    _registerUseCase = ref.watch(registerProvider);
    return const DataState.initial();
  }

  Future<void> register({
    required String username,
    required String email,
    required String password,
    required OnSuccess onSuccess,
    required OnError onErrror,
  }) async {
    await executeTask(
      future: () => _registerUseCase.execute(
        RegisterParam(username: username, email: email, password: password),
      ),
      showLoadingOverlay: true,
      onSuccess: onSuccess,
      onError: onErrror,
    );
  }
}
