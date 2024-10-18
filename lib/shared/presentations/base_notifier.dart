import 'package:car_rental/shared/data/remote/api_exception.dart';
import 'package:car_rental/shared/domain/repositories/data_result.dart';
import 'package:car_rental/core/utils/dialogs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef OnFuture<T> = Future<T> Function();
typedef OnSuccess<T> = void Function(T data);
typedef OnError = void Function(String msg);

abstract class BaseNotifier<State> extends AutoDisposeNotifier<State> {
  String _getErrorMessage(Exception? exception) {
    if (exception == null) {
      return 'An error has occurred';
    } else if (exception is ApiException) {
      return exception.message;
    } else {
      return exception.toString();
    }
  }

  Future<DataResult<T>> executeTaskWithResult<T>({
    required OnFuture<DataResult<T>> future,
    OnSuccess<T>? onSuccess,
    OnError? onError,
    bool showLoadingOverlay = false,
  }) async {
    if (showLoadingOverlay) UDialog.showLoading();
    final result = await future();
    if (showLoadingOverlay) UDialog.popLoading();
    switch (result) {
      case Success<T>():
        onSuccess?.call(result.data);
        break;
      case Error<T>():
        onError?.call(_getErrorMessage(result.exception));
        break;
    }
    return result;
  }

  Future<void> executeTask<T>({
    required OnFuture<DataResult<T>> future,
    OnSuccess<T>? onSuccess,
    OnError? onError,
    bool showLoadingOverlay = false,
  }) async {
    if (showLoadingOverlay) UDialog.showLoading();
    final result = await future();
    if (showLoadingOverlay) UDialog.popLoading();
    switch (result) {
      case Success<T>():
        onSuccess?.call(result.data);
        break;
      case Error<T>():
        onError?.call(_getErrorMessage(result.exception));
        break;
    }
  }

  Future<void> executeMultipleTasks({
    required List<Future<DataResult>> requests,
    OnSuccess<List<dynamic>>? onSuccess,
    Function(List<String> error)? onError,
    bool showLoadingOverlay = false,
  }) async {
    if (showLoadingOverlay) UDialog.showLoading();
    final results = await Future.wait(requests);
    if (showLoadingOverlay) UDialog.popLoading();
    final hasError = results.any((e) => e is Error);
    if (!hasError) {
      onSuccess?.call(results.map((e) => (e as Success).data).toList());
    } else {
      final errors = results.whereType<Error>().toList();
      onError?.call(
        errors.map((err) => _getErrorMessage(err.exception)).toList(),
      );
    }
  }
}
