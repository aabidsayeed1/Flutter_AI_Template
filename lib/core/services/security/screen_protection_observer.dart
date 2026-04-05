import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../logger/log.dart';
import 'screen_protection_service.dart';

/// Listens to GoRouter's [routerDelegate] to block/unblock screen capture
/// for protected routes on every navigation event (go, push, pop, redirect).
///
/// Usage in router module:
/// ```dart
/// final observer = ScreenProtectionObserver();
/// final router = GoRouter(observers: [observer], ...);
/// observer.attachRouter(router);
/// ```
class ScreenProtectionObserver extends NavigatorObserver {
  ScreenProtectionObserver();

  GoRouter? _router;

  /// Attach after GoRouter creation. Starts listening to delegate changes
  /// and immediately checks the current route (catches the initial redirect).
  void attachRouter(GoRouter router) {
    _router = router;
    router.routerDelegate.addListener(_onRouteChange);
  }

  void _onRouteChange() {
    final r = _router;
    if (r == null) return;

    // Defer to next frame so GoRouter's state is fully settled.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final location = r.routeInformationProvider.value.uri.toString();
      Log.debug('ScreenProtection checking route: $location');
      ScreenProtectionService.instance.updateForRoute(location);
    });
  }
}
