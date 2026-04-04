import '../../../../core/base/models/failure.dart';
import '../../../../core/base/repository.dart';
import '../entities/login_entity.dart';
import '../entities/remember_me_entity.dart';
export '../entities/remember_me_entity.dart';
import '../entities/sign_up_entity.dart';

abstract base class AuthRepository extends Repository {
  Future<(LoginResponseEntity?, Failure?)> login(LoginRequestEntity data);
  Future<(SignUpResponseEntity?, Failure?)> register(SignUpRequestEntity data);
  Future<void> logout();
  Future<bool> isLoggedIn();
  Future<void> saveRememberMe(RememberMeEntity data);
  Future<RememberMeEntity> getRememberMe();
}
