import 'auth_remote_data_source.dart';
import '../models/user_model.dart';

class ApiAuthRemoteDataSource implements AuthRemoteDataSource {
  UserModel? _cachedUser;

  @override
  Future<UserModel?> login(String email, String password) async {
    // 🔹 Simulate REST API call
    await Future.delayed(const Duration(seconds: 1));

    // 🔹 Example API response mapping
    _cachedUser = UserModel(id: 'api_123', email: email, name: 'API User');

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
