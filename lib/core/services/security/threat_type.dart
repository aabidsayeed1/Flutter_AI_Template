/// Represents the types of security threats detected by freeRASP.
enum ThreatType {
  appIntegrity(
    title: 'App Integrity Compromised',
    message:
        'This app has been modified or tampered with. For your security, please download the official version from a trusted store.',
    icon: 'shield_warning',
  ),
  obfuscationIssues(
    title: 'Security Configuration Issue',
    message:
        'The app\'s security configuration is not properly set up. Please contact support.',
    icon: 'code_warning',
  ),
  debug(
    title: 'Debugging Detected',
    message:
        'A debugger is attached to this app. For your security, the app cannot run while being debugged.',
    icon: 'bug',
  ),
  deviceBinding(
    title: 'Device Mismatch',
    message:
        'This app installation has been moved to a different device. Please reinstall the app.',
    icon: 'device_warning',
  ),
  deviceId(
    title: 'Device ID Compromised',
    message:
        'The device identifier has been tampered with. The app cannot verify the device integrity.',
    icon: 'device_id',
  ),
  hooks(
    title: 'Hooking Framework Detected',
    message:
        'A hooking framework (e.g., Frida, Xposed) has been detected. The app cannot run in this environment.',
    icon: 'hook',
  ),
  passcode(
    title: 'Device Not Secured',
    message:
        'Your device does not have a passcode or biometric lock set up. Please secure your device to use this app.',
    icon: 'lock_open',
  ),
  privilegedAccess(
    title: 'Rooted/Jailbroken Device',
    message:
        'This device has been rooted or jailbroken. The app cannot run on compromised devices for your security.',
    icon: 'root',
  ),
  secureHardwareNotAvailable(
    title: 'Secure Hardware Unavailable',
    message:
        'This device does not have the required secure hardware. Some security features may not work properly.',
    icon: 'hardware',
  ),
  simulator(
    title: 'Emulator/Simulator Detected',
    message:
        'This app is running on an emulator or simulator. Please use a real device.',
    icon: 'simulator',
  ),
  systemVPN(
    title: 'VPN Detected',
    message:
        'A system VPN connection has been detected. Please disconnect the VPN to continue.',
    icon: 'vpn',
  ),
  devMode(
    title: 'Developer Mode Enabled',
    message:
        'Developer mode is enabled on this device. Please disable it in your device settings to continue.',
    icon: 'developer',
  ),
  adbEnabled(
    title: 'USB Debugging Enabled',
    message:
        'USB debugging (ADB) is enabled on this device. Please disable it in Developer Options to continue.',
    icon: 'usb',
  ),
  unofficialStore(
    title: 'Unofficial Installation Source',
    message:
        'This app was not installed from an official app store. Please download it from a trusted source.',
    icon: 'store',
  ),
  screenshot(
    title: 'Screenshot Detected',
    message: 'A screenshot of the app was captured.',
    icon: 'screenshot',
  ),
  screenRecording(
    title: 'Screen Recording Detected',
    message: 'Screen recording is active. Sensitive content may be at risk.',
    icon: 'screen_record',
  ),
  malware(
    title: 'Malware Detected',
    message:
        'A potentially malicious application has been detected on this device. Please remove suspicious apps.',
    icon: 'malware',
  );

  const ThreatType({
    required this.title,
    required this.message,
    required this.icon,
  });

  final String title;
  final String message;
  final String icon;

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
