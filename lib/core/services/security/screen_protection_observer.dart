import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../logger/log.dart';
import 'screen_protection_service.dart';

/// Observes ALL GoRouter navigation (go, redirect, push, pop) and
/// blocks/unblocks screen capture for protected routes.
///
/// Uses two complementary listeners:
/// - [NavigatorObserver] — fires on push/pop/replace (navigator-level events).
/// - [GoRouterDelegate.addListener] — fires on go/redirect (router-level events).
///
/// Reads the actual location from [GoRouter.routeInformationProvider] which
/// always reflects the current visible URL regardless of navigation method.
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

  /// Attach after GoRouter creation. Also starts listening to delegate changes.
  void attachRouter(GoRouter router) {
    _router = router;
    router.routerDelegate.addListener(_onRouteChange);
  }

  // ── NavigatorObserver (push / pop / replace / remove) ──

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _onRouteChange();

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _onRouteChange();

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) =>
      _onRouteChange();

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _onRouteChange();

  // ── Shared handler ──

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
