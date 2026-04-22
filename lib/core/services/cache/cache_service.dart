import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preference_service.dart';

enum CacheKey {
  // ── Sensitive (stored in FlutterSecureStorage) ──
  accessToken(sensitive: true),
  refreshToken(sensitive: true),
  rememberedEmail(sensitive: true),
  rememberedPassword(sensitive: true),
  user(sensitive: true),

  // ── Non-sensitive (stored in SharedPreferences) ──
  isOnBoardingCompleted,
  isLoggedIn,
  rememberMe,
  language,
  homeUpdateDismissedVersion;

  const CacheKey({this.sensitive = false});

  /// Whether this key holds sensitive data that must be encrypted.
  final bool sensitive;
}

abstract class CacheService {
  Future<void> save<T>(CacheKey key, T value);

  /// Synchronous read — only for **non-sensitive** keys (SharedPreferences).
  /// Throws [UnsupportedError] if called with a sensitive key.
  T? get<T>(CacheKey key);

  /// Async read for **sensitive** keys (FlutterSecureStorage).
  /// Returns the stored string value, or `null` if not found.
  Future<String?> getSecure(CacheKey key);

  Future<void> remove(List<CacheKey> keys);

  Future<void> clear();
}
