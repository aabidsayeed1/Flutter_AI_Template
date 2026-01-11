import 'package:injectable/injectable.dart';

import 'auth_remote_data_source.dart';
import '../models/user_model.dart';

@LazySingleton(as: AuthRemoteDataSource)
class FirebaseAuthRemoteDataSource implements AuthRemoteDataSource {
  UserModel? _cachedUser;

  @override
  Future<UserModel?> login(String email, String password) async {
    // 🔹 Simulate FirebaseAuth sign-in
    await Future.delayed(const Duration(seconds: 1));

    _cachedUser = UserModel(
      id: 'firebase_123',
      email: email,
      name: 'Firebase User',
    );

    return _cachedUser;
  }

  @override
  Future<void> logout() async {
    _cachedUser = null;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    return _cachedUser;
  }

  @override
  Stream<UserModel?> authStateChanges() async* {
    yield _cachedUser;
  }
}
