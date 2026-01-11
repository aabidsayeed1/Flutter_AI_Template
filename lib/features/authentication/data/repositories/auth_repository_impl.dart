import 'package:injectable/injectable.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<User?> login(String email, String password) async {
    final userModel = await remote.login(email, password);
    return userModel; // UserModel extends User
  }

  @override
  Future<void> logout() {
    return remote.logout();
  }

  @override
  Stream<User?> authStateChanges() {
    return remote.authStateChanges();
  }

  @override
  Future<bool> isLoggedIn() async {
    final user = await getCurrentUser();
    return user != null;
  }

  @override
  Future<User?> getCurrentUser() {
    return remote.getCurrentUser();
  }
}
