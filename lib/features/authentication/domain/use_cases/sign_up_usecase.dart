import 'package:injectable/injectable.dart';

import '../../../../core/base/models/failure.dart';
import '../entities/sign_up_entity.dart';
import '../repositories/auth_repository.dart';

@injectable
class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<(SignUpResponseEntity?, Failure?)> call(SignUpRequestEntity data) {
    return repository.register(data);
  }
}
