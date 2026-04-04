import 'package:injectable/injectable.dart';

import '../repositories/auth_repository.dart';

@injectable
class RememberMeUseCase {
  final AuthRepository repository;

  RememberMeUseCase(this.repository);

  Future<RememberMeEntity> get() => repository.getRememberMe();

  Future<void> save(RememberMeEntity data) => repository.saveRememberMe(data);
}
