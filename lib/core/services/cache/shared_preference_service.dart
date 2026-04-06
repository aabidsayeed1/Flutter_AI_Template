part of 'cache_service.dart';

class SharedPreferencesService implements CacheService {
  SharedPreferencesService(this._prefs, this._secureStorage);

  final SharedPreferences _prefs;
  final FlutterSecureStorage _secureStorage;

  // ── Save ───────────────────────────────────────────────────────────────

  @override
  Future<void> save<T>(CacheKey key, T value) async {
    if (key.sensitive) {
      await _secureStorage.write(key: key.name, value: value.toString());
      return;
    }

    switch (T) {
      case const (String):
        await _prefs.setString(key.name, value as String);
        break;
      case const (int):
        await _prefs.setInt(key.name, value as int);
        break;
      case const (bool):
        await _prefs.setBool(key.name, value as bool);
        break;
      case const (double):
        await _prefs.setDouble(key.name, value as double);
        break;
      default:
        await _prefs.setString(key.name, value as String);
    }
  }

  // ── Get ────────────────────────────────────────────────────────────────

  @override
  T? get<T>(CacheKey key) {
    if (key.sensitive) {
      // Secure storage is async-only — use getSecure() for sensitive keys.
      // This returns null; callers must use getSecure() instead.
      throw UnsupportedError(
        'Use getSecure() for sensitive key "${key.name}". '
        'FlutterSecureStorage does not support synchronous reads.',
      );
    }

    return switch (T) {
      const (String) => _prefs.getString(key.name) as T?,
      const (int) => _prefs.getInt(key.name) as T?,
      const (bool) => _prefs.getBool(key.name) as T?,
      const (double) => _prefs.getDouble(key.name) as T?,
      _ => _prefs.get(key.name) as T?,
    };
  }

  @override
  Future<String?> getSecure(CacheKey key) async {
    return _secureStorage.read(key: key.name);
  }

  // ── Remove ─────────────────────────────────────────────────────────────

  @override
  Future<void> remove(List<CacheKey> keys) async {
    for (final key in keys) {
      if (key.sensitive) {
        await _secureStorage.delete(key: key.name);
      } else {
        await _prefs.remove(key.name);
      }
    }
  }

  @override
  Future<void> clear() async {
    await _prefs.clear();
    await _secureStorage.deleteAll();
  }
}
