import 'package:injectable/injectable.dart';

import '../../../../core/base/models/failure.dart';
import '../entities/login_entity.dart';
import '../repositories/auth_repository.dart';

@injectable
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<(LoginResponseEntity?, Failure?)> call(LoginRequestEntity data) {
    return repository.login(data);
  }
}
