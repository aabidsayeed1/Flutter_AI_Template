import 'package:freerasp/freerasp.dart';

import '../../logger/log.dart';
import '../../router/routes.dart';

/// Controls screen capture blocking based on the current route.
///
/// Certain sensitive pages (e.g., payment, OTP verification) should prevent
/// screenshots and screen recording. This service manages that automatically
/// when integrated with the router observer.
///
/// Usage:
/// ```dart
/// // The ScreenProtectionObserver handles this automatically, but you can
/// // also control it manually:
/// ScreenProtectionService.instance.updateForRoute('/payment');
/// ```
class ScreenProtectionService {
  ScreenProtectionService._();

  static final ScreenProtectionService instance = ScreenProtectionService._();

  /// Routes where screen capture should be blocked.
  ///
  /// Add full route paths (as they appear in GoRouter) to this set.
  /// Supports exact matches and prefix matches for nested routes.
  static final Set<String> _protectedRoutes = {
    // Examples — uncomment or add your own:
    // '/payment',
    // '/payment/confirm',
    // '/otp-verification',
    Routes.login,
  };

  bool _isCurrentlyBlocked = false;

  /// Whether screen capture is currently being blocked.
  bool get isBlocked => _isCurrentlyBlocked;

  /// Checks if the given [route] should have screen capture blocked
  /// and toggles accordingly.
  Future<void> updateForRoute(String route) async {
    final shouldBlock = _isProtectedRoute(route);

    if (shouldBlock == _isCurrentlyBlocked) return;

    await _setBlocked(shouldBlock);
    Log.info(
      'Screen capture ${shouldBlock ? 'BLOCKED' : 'UNBLOCKED'} for: $route',
    );
  }

  /// Manually block screen capture (e.g., when showing sensitive data).
  Future<void> block() async {
    if (_isCurrentlyBlocked) return;
    await _setBlocked(true);
    Log.info('Screen capture manually BLOCKED');
  }

  /// Manually unblock screen capture.
  Future<void> unblock() async {
    if (!_isCurrentlyBlocked) return;
    await _setBlocked(false);
    Log.info('Screen capture manually UNBLOCKED');
  }

  /// Returns `true` if [route] matches any protected route (exact or prefix).
  bool _isProtectedRoute(String route) {
    for (final protected in _protectedRoutes) {
      if (route == protected || route.startsWith('$protected/')) {
        return true;
      }
    }
    return false;
  }

  Future<void> _setBlocked(bool enabled) async {
    await Talsec.instance.blockScreenCapture(enabled: enabled);
    _isCurrentlyBlocked = enabled;
  }
}
