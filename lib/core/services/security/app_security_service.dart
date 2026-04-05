import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freerasp/freerasp.dart';

import '../../config/flavor.dart';
import '../../localization/l10n/app_localizations.dart';
import '../../logger/log.dart';
import '../../router/router.dart';
import '../../widgets/security/threat_warning_page.dart';
import 'threat_type.dart';

/// Service responsible for app security monitoring using freeRASP.
///
/// Configures Talsec SDK with per-flavor settings and navigates to a
/// warning page when a security threat is detected.
class AppSecurityService {
  AppSecurityService._();

  static final AppSecurityService instance = AppSecurityService._();

  // ── Template debug keystore hash ──────────────────────────────────────
  // Generated from: android/app/template-keystore.jks (alias: template-key)
  // This is for development only. Replace with your release hash for production.
  //
  // How to generate your own:
  //   1. keytool -list -v -keystore <your-keystore.jks> -storepass <password>
  //   2. Copy the SHA256 fingerprint (e.g., 36:FF:CE:64:...)
  //   3. Convert to Base64:
  //      echo "36:FF:CE:64:..." | tr -d ':' | xxd -r -p | base64
  //   4. For Google Play App Signing: Google Play Console → Setup →
  //      App signing → App signing key certificate → SHA-256
  static const _debugSigningHash =
      'Nv/OZEckPfUIhzq+GX30lL4SK5WkDttDY+py9FGXwsQ=';

  /// Initializes freeRASP with the appropriate configuration for the
  /// current flavor and attaches threat callbacks.
  Future<void> initialize() async {
    _logConfigReminders();

    final config = TalsecConfig(
      androidConfig: AndroidConfig(
        packageName: _androidPackageName,
        signingCertHashes: _androidSigningHashes,
        supportedStores: ['com.sec.android.app.samsungapps'],
      ),
      iosConfig: IOSConfig(bundleIds: _iosBundleIds, teamId: _iosTeamId),
      // TODO: Replace with your actual watcher email before production release
      watcherMail: 'security@yourcompany.com',
      isProd: F.isProd,
    );

    _attachCallbacks();

    await Talsec.instance.start(config);
    Log.info('AppSecurityService initialized (isProd: ${F.isProd})');
  }

  /// Prints debug-only reminders so developers know what to replace
  /// before shipping to production.
  void _logConfigReminders() {
    if (!kDebugMode) return;

    Log.warning(
      '╔══════════════════════════════════════════════════════════╗\n'
      '║           freeRASP — TEMPLATE CONFIGURATION             ║\n'
      '╠══════════════════════════════════════════════════════════╣\n'
      '║ Using template debug keystore hash.                     ║\n'
      '║ Before production release, you MUST replace:            ║\n'
      '║                                                         ║\n'
      '║ 1. Android signing hash (_debugSigningHash)             ║\n'
      '║    → keytool -list -v -keystore <your.jks>              ║\n'
      '║    → Convert SHA256 to Base64                           ║\n'
      '║                                                         ║\n'
      '║ 2. iOS Team ID (_iosTeamId)                             ║\n'
      '║    → https://developer.apple.com/account                ║\n'
      '║                                                         ║\n'
      '║ 3. Watcher email (watcherMail)                          ║\n'
      '║    → For Talsec security reports                        ║\n'
      '╚══════════════════════════════════════════════════════════╝',
    );
  }

  void _attachCallbacks() {
    final callback = ThreatCallback(
      onAppIntegrity: () => _handleThreat(ThreatType.appIntegrity),
      onObfuscationIssues: () => _handleThreat(ThreatType.obfuscationIssues),
      onDebug: () => _handleThreat(ThreatType.debug),
      onDeviceBinding: () => _handleThreat(ThreatType.deviceBinding),
      onDeviceID: () => _handleThreat(ThreatType.deviceId),
      onHooks: () => _handleThreat(ThreatType.hooks),
      onPasscode: () => _handleThreat(ThreatType.passcode),
      onPrivilegedAccess: () => _handleThreat(ThreatType.privilegedAccess),
      onSecureHardwareNotAvailable: () =>
          _handleThreat(ThreatType.secureHardwareNotAvailable),
      onSimulator: () => _handleThreat(ThreatType.simulator),
      onSystemVPN: () => _handleThreat(ThreatType.systemVPN),
      onDevMode: () => _handleThreat(ThreatType.devMode),
      onADBEnabled: () => _handleThreat(ThreatType.adbEnabled),
      onUnofficialStore: () => _handleThreat(ThreatType.unofficialStore),
      onScreenshot: () => _handleThreat(ThreatType.screenshot),
      onScreenRecording: () => _handleThreat(ThreatType.screenRecording),
      onMalware: (_) => _handleThreat(ThreatType.malware),
    );

    Talsec.instance.attachListener(callback);
  }

  void _handleThreat(ThreatType threat) {
    final enL10n = lookupAppLocalizations(const Locale('en'));
    Log.warning(
      'Security threat detected: ${threat.name} — ${threat.title(enL10n)}',
    );

    final navigator = rootNavigatorKey.currentState;
    if (navigator == null) return;

    // Push the threat warning page as a full-screen modal route so it
    // overlays whatever is currently on screen. Non-blocking threats
    // allow the user to dismiss; blocking threats trap the user.
    navigator.push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (_) => ThreatWarningPage(threat: threat),
      ),
    );
  }

  // ── Per-flavor Android configuration ──────────────────────────────────

  String get _androidPackageName {
    switch (F.appFlavor) {
      case Flavor.dev:
        return 'com.fluttertemplate2025.dev';
      case Flavor.qa:
        return 'com.fluttertemplate2025.qa';
      case Flavor.uat:
        return 'com.fluttertemplate2025.uat';
      case Flavor.prod:
        return 'com.fluttertemplate2025';
    }
  }

  // ── Android signing hashes ─────────────────────────────────────────────
  // For production: replace _debugSigningHash with your release keystore hash.
  // If using Google Play App Signing, add BOTH your upload key hash AND the
  // Play-managed signing key hash.
  List<String> get _androidSigningHashes {
    // TODO(production): Replace with your release signing certificate hash(es).
    return [_debugSigningHash];
  }

  // ── Per-flavor iOS configuration ──────────────────────────────────────

  List<String> get _iosBundleIds {
    switch (F.appFlavor) {
      case Flavor.dev:
        return ['com.fluttertemplate2025.dev'];
      case Flavor.qa:
        return ['com.fluttertemplate2025.qa'];
      case Flavor.uat:
        return ['com.fluttertemplate2025.uat'];
      case Flavor.prod:
        return ['com.fluttertemplate2025'];
    }
  }

  // TODO(production): Replace with your Apple Developer Team ID.
  //       Find it at: https://developer.apple.com/account → Membership Details.
  String get _iosTeamId => 'M8AK35';
}
