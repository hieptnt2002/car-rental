sealed class DataResult<T> {}

class Success<T> extends DataResult<T> {
  final T data;
  Success({required this.data});
}

class Error<T> extends DataResult<T> {
  final Exception? exception;
  Error({this.exception});
}
