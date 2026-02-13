import 'models/failure.dart';
import 'models/result.dart';

abstract base class Repository<T> {
  Future<Result<T, Failure>> asyncGuard(Future<T> Function() operation) async {
    try {
      final result = await operation();
      return Success(result);
    } on Exception catch (e) {
      return Error(Failure.mapExceptionToFailure(e));
    }
  }

  Result<T, Failure> guard(T Function() operation) {
    try {
      final result = operation();
      return Success(result);
    } on Exception catch (e) {
      return Error(Failure.mapExceptionToFailure(e));
    }
  }
}
