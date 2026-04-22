import 'package:package_info_plus/package_info_plus.dart';

/// Singleton for app version and package info.
class AppInfoService {
  static final AppInfoService instance = AppInfoService._();
  AppInfoService._();

  late final PackageInfo _info;
  bool _initialized = false;

  /// Call once at app startup.
  Future<void> initialize() async {
    _info = await PackageInfo.fromPlatform();
    _initialized = true;
  }

  void _checkInit() {
    if (!_initialized) {
      throw Exception('AppInfoService not initialized. Call init() first.');
    }
  }

  String get version {
    _checkInit();
    return _info.version;
  }

  String get buildNumber {
    _checkInit();
    return _info.buildNumber;
  }

  String get androidAppId {
    _checkInit();
    return _info.packageName;
  }

  String get iOSAppId {
    _checkInit();
    return _info.packageName;
  }

  PackageInfo get packageInfo {
    _checkInit();
    return _info;
  }
}
