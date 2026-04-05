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

  /// Routes where screen capture should be blocked (exact match only).
  ///
  /// Only the exact path is protected. Child routes are NOT affected.
  /// Example: adding `/login` blocks `/login` but NOT `/login/registration`.
  ///
  /// **Use full paths** (as shown in GoRouter's "Full paths for routes" log).
  static final Set<String> _protectedRoutes = {
    // Examples — uncomment or add your own:
    // '/otp-verification',
    Routes.profile,
  };

  /// Routes where screen capture is blocked for the route AND all children.
  ///
  /// Uses prefix matching. Example: adding `/payment` also blocks
  /// `/payment/confirm`, `/payment/details`, etc.
  ///
  /// **Use full paths** (as shown in GoRouter's "Full paths for routes" log).
  static final Set<String> _protectedRoutePrefixes = {
    // Examples — uncomment or add your own:
    // '/payment',
    '${Routes.login}/${Routes.registration}',
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

  /// Returns `true` if [route] matches any protected route.
  ///
  /// Checks exact matches in [_protectedRoutes] and prefix matches
  /// in [_protectedRoutePrefixes].
  bool _isProtectedRoute(String route) {
    if (_protectedRoutes.contains(route)) return true;

    for (final prefix in _protectedRoutePrefixes) {
      if (route == prefix || route.startsWith('$prefix/')) {
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
