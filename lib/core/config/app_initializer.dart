import 'package:flutter/services.dart';

import '../logger/log.dart';
import '../services/security/app_security_service.dart';

/// Centralizes all app-level initialization.
///
/// Any third-party SDK, service, or platform setup that must run before
/// `runApp()` goes here. Keeps `main.dart` clean and gives a single
/// place to manage startup dependencies.
///
/// Each init step is wrapped individually so one failure doesn't block
/// the others — the app always starts.
///
/// Usage in `main.dart`:
/// ```dart
/// await configureDependencies();
/// await AppInitializer.initialize();
/// runApp(const MyApp());
/// ```
class AppInitializer {
  AppInitializer._();

  /// Runs all app initialization steps in the correct order.
  ///
  /// Call this **after** `configureDependencies()` so that GetIt
  /// registrations are available for services that need them.
  static Future<void> initialize() async {
    await _initOrientations();
    await _safeInit('Security (freeRASP)', _initSecurity);
    // Future initializations go here:
    // await _safeInit('Firebase', _initFirebase);
    // await _safeInit('Analytics', _initAnalytics);
    // await _safeInit('Notifications', _initNotifications);
    // await _safeInit('RemoteConfig', _initRemoteConfig);

    Log.info('AppInitializer completed');
  }

  /// Wraps a third-party initialization in a try-catch so that a single
  /// failing SDK never prevents the app from starting.
  ///
  /// Platform essentials (orientations, DI) should NOT use this — they
  /// must succeed. Only use for third-party/optional services.
  static Future<void> _safeInit(
    String name,
    Future<void> Function() init,
  ) async {
    try {
      await init();
    } catch (error, stackTrace) {
      Log.error('Failed to initialize $name: $error');
      Log.fatal(error: error, stackTrace: stackTrace);
    }
  }

  /// Lock orientations to portrait only.
  static Future<void> _initOrientations() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  /// Initialize freeRASP app security monitoring.
  static Future<void> _initSecurity() async {
    await AppSecurityService.instance.initialize();
  }
}
