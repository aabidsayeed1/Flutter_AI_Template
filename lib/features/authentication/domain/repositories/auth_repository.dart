import '../entities/user.dart';

abstract class AuthRepository {
  Future<User?> getCurrentUser();
  Future<bool> isLoggedIn();
  Future<User?> login(String email, String password);
  Future<void> logout();
  Stream<User?> authStateChanges();
}
