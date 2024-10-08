import 'package:car_rental/shared/data/remote/api_exception.dart';
import 'package:car_rental/shared/domain/repositories/data_result.dart';
import 'package:car_rental/core/utils/dialogs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef OnFuture<T> = Future<T> Function();
typedef OnSuccess<T> = void Function(T data);
typedef OnError = void Function(String msg);
typedef OnLoading = void Function(bool isLoading);

abstract class BaseNotifier<State> extends AutoDisposeNotifier<State> {
  void _handleLoading({
    required bool showLoadingOverlay,
    OnLoading? onLoading,
    required bool isLoading,
  }) {
    if (showLoadingOverlay && onLoading == null) {
      isLoading ? UDialog.showLoading() : UDialog.popLoading();
    } else {
      onLoading?.call(isLoading);
    }
  }

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
    OnLoading? onLoading,
  }) async {
    _handleLoading(
      showLoadingOverlay: showLoadingOverlay,
      onLoading: onLoading,
      isLoading: true,
    );
    final result = await future();
    _handleLoading(
      showLoadingOverlay: showLoadingOverlay,
      onLoading: onLoading,
      isLoading: false,
    );
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
    OnLoading? onLoading,
  }) async {
    _handleLoading(
      showLoadingOverlay: showLoadingOverlay,
      onLoading: onLoading,
      isLoading: true,
    );
    final result = await future();
    _handleLoading(
      showLoadingOverlay: showLoadingOverlay,
      onLoading: onLoading,
      isLoading: false,
    );
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
    OnLoading? onLoading,
  }) async {
    _handleLoading(
      showLoadingOverlay: showLoadingOverlay,
      onLoading: onLoading,
      isLoading: true,
    );
    final results = await Future.wait(requests);
    _handleLoading(
      showLoadingOverlay: showLoadingOverlay,
      onLoading: onLoading,
      isLoading: false,
    );
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
