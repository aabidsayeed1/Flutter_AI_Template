import 'models/failure.dart';

abstract base class Repository {
  Future<(T?, Failure?)> asyncGuard<T>(Future<T> Function() operation) async {
    try {
      final result = await operation();
      return (result, null);
    } on Exception catch (e) {
      return (null, Failure.mapExceptionToFailure(e));
    }
  }

  (T?, Failure?) guard<T>(T Function() operation) {
    try {
      final result = operation();
      return (result, null);
    } on Exception catch (e) {
      return (null, Failure.mapExceptionToFailure(e));
    }
  }
}
