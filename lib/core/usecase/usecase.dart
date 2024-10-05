abstract class UseCase<T, P> {
  Future<T> execute(P params);
}

abstract class UseCaseNoParam<T> {
  Future<T> execute();
}
