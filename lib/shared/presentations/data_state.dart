class DataState<T> {
  final T? value;
  final bool isLoading;
  final String? errorMessage;
  final StackTrace? stackTrace;

  const DataState.initial()
      : value = null,
        isLoading = false,
        errorMessage = null,
        stackTrace = null;

  const DataState.loading()
      : value = null,
        isLoading = true,
        errorMessage = null,
        stackTrace = null;

  const DataState.data(T data)
      : value = data,
        isLoading = false,
        errorMessage = null,
        stackTrace = null;

  const DataState.error(String message, {StackTrace? stack})
      : value = null,
        isLoading = false,
        errorMessage = message,
        stackTrace = stack;

  bool get hasError => errorMessage != null;

  bool get hasData => value != null;

  R when<R>({
    required R Function() loading,
    required R Function(T data) data,
    required R Function(String message, StackTrace? stackTrace) error,
  }) {
    if (isLoading) {
      return loading();
    } else if (hasData) {
      return data(value as T);
    } else if (hasError) {
      return error(errorMessage!, stackTrace);
    } else {
      return loading();
    }
  }
}
