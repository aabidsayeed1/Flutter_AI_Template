import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

import '../logger/log.dart';

/// App lifecycle states exposed to the rest of the app.
enum AppLifecycleStatus { resumed, inactive, paused, hidden, detached }

extension _AppLifecycleMapper on AppLifecycleState {
  AppLifecycleStatus get status {
    switch (this) {
      case AppLifecycleState.resumed:
        return AppLifecycleStatus.resumed;
      case AppLifecycleState.inactive:
        return AppLifecycleStatus.inactive;
      case AppLifecycleState.paused:
        return AppLifecycleStatus.paused;
      case AppLifecycleState.hidden:
        return AppLifecycleStatus.hidden;
      case AppLifecycleState.detached:
        return AppLifecycleStatus.detached;
    }
  }
}

/// Global lifecycle observer service.
///
/// Register once at app startup and subscribe to [statusStream] where needed.
@lazySingleton
class AppLifecycleService with WidgetsBindingObserver {
  final _statusController = StreamController<AppLifecycleStatus>.broadcast();

  AppLifecycleStatus _currentStatus = AppLifecycleStatus.resumed;
  bool _initialized = false;

  /// Stream of lifecycle transitions.
  Stream<AppLifecycleStatus> get statusStream => _statusController.stream;

  /// Current app lifecycle status.
  AppLifecycleStatus get currentStatus => _currentStatus;

  /// Whether app is currently in foreground interactive state.
  bool get isForeground =>
      _currentStatus == AppLifecycleStatus.resumed ||
      _currentStatus == AppLifecycleStatus.inactive;

  /// Starts lifecycle observation.
  ///
  /// Safe to call multiple times; only the first call registers the observer.
  void initialize() {
    if (_initialized) return;
    _initialized = true;

    WidgetsBinding.instance.addObserver(this);

    final initialState = WidgetsBinding.instance.lifecycleState;
    if (initialState != null) {
      _updateStatus(initialState.status);
    }

    Log.info('AppLifecycleService initialized: ${_currentStatus.name}');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _updateStatus(state.status);
  }

  void _updateStatus(AppLifecycleStatus nextStatus) {
    if (_currentStatus == nextStatus) return;

    _currentStatus = nextStatus;
    _statusController.add(nextStatus);
    Log.info('App lifecycle changed: ${nextStatus.name}');
  }

  @disposeMethod
  void dispose() {
    if (_initialized) {
      WidgetsBinding.instance.removeObserver(this);
      _initialized = false;
    }
    _statusController.close();
  }
}
