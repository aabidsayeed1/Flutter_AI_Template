import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_remote_data_source.dart';
import '../models/user_model.dart';

@LazySingleton(as: AuthRemoteDataSource)
class FirebaseAuthRemoteDataSource implements AuthRemoteDataSource {
  UserModel? _cachedUser;
  final SharedPreferences prefs;
  static const _keyUser = 'logged_user';
  FirebaseAuthRemoteDataSource(this.prefs);

  @override
  Future<UserModel?> login(String email, String password) async {
    // 🔹 Simulate FirebaseAuth sign-in
    await Future.delayed(const Duration(seconds: 1));

    _cachedUser = UserModel(
      id: 'firebase_123',
      email: email,
      name: 'Firebase User',
    );
    prefs.setString(_keyUser, _cachedUser!.toJson());
    return _cachedUser;
  }

  @override
  Future<void> logout() async {
    prefs.setString(_keyUser, '');
    _cachedUser = null;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    return _cachedUser;
  }

  @override
  Stream<UserModel?> authStateChanges() async* {
    if (prefs.getString(_keyUser) != null &&
        prefs.getString(_keyUser)!.isNotEmpty) {
      _cachedUser = UserModel.fromJson(prefs.getString(_keyUser)!);
    }
    yield _cachedUser;
  }
}
