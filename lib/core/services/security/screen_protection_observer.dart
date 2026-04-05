import 'package:go_router/go_router.dart';

import 'screen_protection_service.dart';

/// Listens to GoRouter's route changes and automatically blocks/unblocks
/// screen capture for protected routes.
///
/// Attach to the router after creation:
/// ```dart
/// final router = GoRouter(...);
/// ScreenProtectionObserver.attachTo(router);
/// ```
class ScreenProtectionObserver {
  ScreenProtectionObserver._(this._router) {
    _router.routerDelegate.addListener(_onRouteChange);
  }

  final GoRouter _router;
  static ScreenProtectionObserver? _instance;

  /// Attaches the observer to the given [router]. Safe to call multiple times.
  static void attachTo(GoRouter router) {
    _instance ??= ScreenProtectionObserver._(router);
  }

  void _onRouteChange() {
    final location = _router.routerDelegate.currentConfiguration.uri.toString();
    ScreenProtectionService.instance.updateForRoute(location);
  }
}
