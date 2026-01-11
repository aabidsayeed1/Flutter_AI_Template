import 'package:injectable/injectable.dart';

import '../entities/user.dart';
import '../repositories/auth_repository.dart';

@injectable
class ObserveAuthStateUseCase {
  final AuthRepository repository;

  ObserveAuthStateUseCase(this.repository);

  Stream<User?> call() {
    return repository.authStateChanges();
  }
}
