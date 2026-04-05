import 'package:flutter_template_2025/core/localization/l10n/app_localizations.dart';

/// Represents the types of security threats detected by freeRASP.
enum ThreatType {
  appIntegrity,
  obfuscationIssues,
  debug,
  deviceBinding,
  deviceId,
  hooks,
  passcode,
  privilegedAccess,
  secureHardwareNotAvailable,
  simulator,
  systemVPN,
  devMode,
  adbEnabled,
  unofficialStore,
  screenshot,
  screenRecording,
  malware;

  /// Localized title for this threat.
  String title(AppLocalizations l10n) {
    return switch (this) {
      appIntegrity => l10n.threatAppIntegrityTitle,
      obfuscationIssues => l10n.threatObfuscationTitle,
      debug => l10n.threatDebugTitle,
      deviceBinding => l10n.threatDeviceBindingTitle,
      deviceId => l10n.threatDeviceIdTitle,
      hooks => l10n.threatHooksTitle,
      passcode => l10n.threatPasscodeTitle,
      privilegedAccess => l10n.threatPrivilegedAccessTitle,
      secureHardwareNotAvailable => l10n.threatSecureHardwareTitle,
      simulator => l10n.threatSimulatorTitle,
      systemVPN => l10n.threatVpnTitle,
      devMode => l10n.threatDevModeTitle,
      adbEnabled => l10n.threatAdbTitle,
      unofficialStore => l10n.threatUnofficialStoreTitle,
      screenshot => l10n.threatScreenshotTitle,
      screenRecording => l10n.threatScreenRecordingTitle,
      malware => l10n.threatMalwareTitle,
    };
  }

  /// Localized message for this threat.
  String message(AppLocalizations l10n) {
    return switch (this) {
      appIntegrity => l10n.threatAppIntegrityMessage,
      obfuscationIssues => l10n.threatObfuscationMessage,
      debug => l10n.threatDebugMessage,
      deviceBinding => l10n.threatDeviceBindingMessage,
      deviceId => l10n.threatDeviceIdMessage,
      hooks => l10n.threatHooksMessage,
      passcode => l10n.threatPasscodeMessage,
      privilegedAccess => l10n.threatPrivilegedAccessMessage,
      secureHardwareNotAvailable => l10n.threatSecureHardwareMessage,
      simulator => l10n.threatSimulatorMessage,
      systemVPN => l10n.threatVpnMessage,
      devMode => l10n.threatDevModeMessage,
      adbEnabled => l10n.threatAdbMessage,
      unofficialStore => l10n.threatUnofficialStoreMessage,
      screenshot => l10n.threatScreenshotMessage,
      screenRecording => l10n.threatScreenRecordingMessage,
      malware => l10n.threatMalwareMessage,
    };
  }

  /// Whether this threat should block the app completely.
  bool get isBlocking {
    switch (this) {
      case ThreatType.appIntegrity:
      case ThreatType.hooks:
      case ThreatType.privilegedAccess:
      case ThreatType.debug:
      case ThreatType.unofficialStore:
      case ThreatType.malware:
        return true;
      case ThreatType.obfuscationIssues:
      case ThreatType.deviceBinding:
      case ThreatType.deviceId:
      case ThreatType.passcode:
      case ThreatType.secureHardwareNotAvailable:
      case ThreatType.simulator:
      case ThreatType.systemVPN:
      case ThreatType.devMode:
      case ThreatType.adbEnabled:
      case ThreatType.screenshot:
      case ThreatType.screenRecording:
        return false;
    }
  }
}
