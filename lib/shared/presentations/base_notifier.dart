import 'package:car_rental/shared/domain/repositories/data_result.dart';
import 'package:car_rental/core/utils/dialogs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef OnFuture<T> = Future<T> Function();
typedef OnSuccess<T> = void Function(T data);
typedef OnError = void Function(Error e);
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
        onError?.call(result);
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
        onError?.call(result);
        break;
    }
  }

  Future<void> executeMultipleTasks({
    required List<Future<DataResult>> requests,
    OnSuccess<List<dynamic>>? onSuccess,
    Function(List<Error<dynamic>> error)? onError,
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
      onError?.call(results.whereType<Error>().toList());
    }
  }
}

// abstract class BaseNotifier<S> extends AutoDisposeNotifier<DataState<S>> {
//   Future<void> handleTask<T>({
//     required OnFuture<DataResult<T>> future,
//     OnSuccess<T>? onSuccess,
//     OnError? onError,
//     bool showLoadingOverlay = false,
//   }) async {
//     if (showLoadingOverlay) {
//       UDialog.showLoading();
//     } else {
//       state = const DataState.loading();
//     }
//     final result = await future.call();
//     if (showLoadingOverlay) UDialog.popLoading();
//     switch (result) {
//       case Success<T>():
//         onSuccess?.call(result.data);
//         break;
//       case Error<T>():
//         final exp = result.exception;
//         if (exp is ApiException) {
//           state = DataState.error(exp.message);
//         }
//         onError?.call(result);
//         break;
//     }
//   }

//   Future<void> handleMultiTask({
//     required List<Future<DataResult>> requests,
//     OnSuccess<List<dynamic>>? onSuccess,
//     Function(List<Error<dynamic>> error)? onError,
//     bool showLoadingOverlay = false,
//   }) async {
//     if (showLoadingOverlay) UDialog.showLoading();
//     final result = await Future.wait(requests);
//     if (showLoadingOverlay) UDialog.popLoading();
//     final isSuccess = result.where((e) => e is! Success).isEmpty;
//     if (isSuccess) {
//       onSuccess?.call(
//         result.map((e) {
//           if (e is Success) {
//             return e.data;
//           }
//         }).toList(),
//       );
//     } else {
//       state = const DataState.error('');
//       onError?.call(
//         result
//             .map((e) {
//               if (e is Error) {
//                 return e;
//               }
//             })
//             .whereType<Error>()
//             .toList(),
//       );
//     }
//   }
// }
