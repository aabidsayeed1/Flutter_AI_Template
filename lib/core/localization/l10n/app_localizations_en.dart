// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flutter Template 2025';

  @override
  String get home => 'Home';

  @override
  String get featured => 'Featured';

  @override
  String get search => 'Search';

  @override
  String get profile => 'Profile';

  @override
  String get login => 'Login';

  @override
  String get createNewPassword => 'Create New password';

  @override
  String get createNewPasswordHint =>
      'Your new password must be different from previous used passwords.';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get passwordChangeSuccess => 'Password Changed Successfully';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get isRequired => 'This field is required';

  @override
  String get validEmail => 'Please enter valid email address';

  @override
  String get enterAssociatedEmail =>
      'Enter the email associated with your account and we’ll send an email with instructions to reset your password.';

  @override
  String minLengthValidation(int min) {
    return 'This field must be at least $min characters long';
  }

  @override
  String maxLengthValidation(int max) {
    return 'This field must be at most $max characters long';
  }

  @override
  String get yourPasswordChanged =>
      'Your password has been changed successfully.';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get logout => 'Logout';

  @override
  String get getStarted => 'Get Started';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get forgotPassword => 'Forgot password';

  @override
  String get backToLogin => 'Back to login';

  @override
  String get continueAction => 'Continue';

  @override
  String get signUp => 'Sign up';

  @override
  String get signIn => 'Sign in';

  @override
  String get email => 'Email';

  @override
  String get emailAddress => 'Email Address';

  @override
  String get password => 'Password';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get dontHaveAccount => 'Don\'t have an account? ';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get checkYourMail => 'Check your mail';

  @override
  String get enterVerificationCode =>
      'Please enter 4 digit code sent to your mail hello**@gmail.com.';

  @override
  String get didntGetCode => 'Didn\'t get a code? ';

  @override
  String get clickToResend => 'Click to resend';

  @override
  String get didNotReceiveEmail =>
      'Did not receive the email? Check your spam filter. or ';

  @override
  String get tryAnotherEmail => 'try another email address';

  @override
  String get learnFlutterTitle => 'Learn Flutter with comprehensive tutorials.';

  @override
  String get learnFlutterSubtitle =>
      'Step-by-step guides for building Flutter apps.';

  @override
  String get learnFlutterDescription =>
      'Get notifications for new tutorials and updates.';

  @override
  String get joinCommunityTitle => 'Join the Flutter community.';

  @override
  String get joinCommunitySubtitle => 'Connect with other Flutter developers.';

  @override
  String get joinCommunityDescription =>
      'Participate in community events and discussions.';

  @override
  String get buildDeployTitle => 'Build and deploy Flutter apps easily.';

  @override
  String get buildDeploySubtitle =>
      'Access tools and resources for app development.';

  @override
  String get buildDeployDescription =>
      'Deploy your apps to multiple platforms with ease.';

  @override
  String get english => 'English';

  @override
  String get bangla => 'Bangla';

  @override
  String get arabic => 'Arabic';

  @override
  String passwordMinLengthValidation(String minLength) {
    return 'Password must be at least $minLength characters';
  }

  @override
  String get passwordNumberValidation =>
      'Password must contain at least one number';

  @override
  String get passwordLowerCaseValidation =>
      'Password must contain at least one lowercase letter';

  @override
  String get passwordUpperCaseValidation =>
      'Password must contain at least one uppercase letter';

  @override
  String get passwordSpecialCharValidation =>
      'Password must contain at least one special character';

  @override
  String get threatAppIntegrityTitle => 'App Integrity Compromised';

  @override
  String get threatAppIntegrityMessage =>
      'This app has been modified or tampered with. For your security, please download the official version from a trusted store.';

  @override
  String get threatObfuscationTitle => 'Security Configuration Issue';

  @override
  String get threatObfuscationMessage =>
      'The app\'s security configuration is not properly set up. Please contact support.';

  @override
  String get threatDebugTitle => 'Debugging Detected';

  @override
  String get threatDebugMessage =>
      'A debugger is attached to this app. For your security, the app cannot run while being debugged.';

  @override
  String get threatDeviceBindingTitle => 'Device Mismatch';

  @override
  String get threatDeviceBindingMessage =>
      'This app installation has been moved to a different device. Please reinstall the app.';

  @override
  String get threatDeviceIdTitle => 'Device ID Compromised';

  @override
  String get threatDeviceIdMessage =>
      'The device identifier has been tampered with. The app cannot verify the device integrity.';

  @override
  String get threatHooksTitle => 'Hooking Framework Detected';

  @override
  String get threatHooksMessage =>
      'A hooking framework (e.g., Frida, Xposed) has been detected. The app cannot run in this environment.';

  @override
  String get threatPasscodeTitle => 'Device Not Secured';

  @override
  String get threatPasscodeMessage =>
      'Your device does not have a passcode or biometric lock set up. Please secure your device to use this app.';

  @override
  String get threatPrivilegedAccessTitle => 'Rooted/Jailbroken Device';

  @override
  String get threatPrivilegedAccessMessage =>
      'This device has been rooted or jailbroken. The app cannot run on compromised devices for your security.';

  @override
  String get threatSecureHardwareTitle => 'Secure Hardware Unavailable';

  @override
  String get threatSecureHardwareMessage =>
      'This device does not have the required secure hardware. Some security features may not work properly.';

  @override
  String get threatSimulatorTitle => 'Emulator/Simulator Detected';

  @override
  String get threatSimulatorMessage =>
      'This app is running on an emulator or simulator. Please use a real device.';

  @override
  String get threatVpnTitle => 'VPN Detected';

  @override
  String get threatVpnMessage =>
      'A system VPN connection has been detected. Please disconnect the VPN to continue.';

  @override
  String get threatDevModeTitle => 'Developer Mode Enabled';

  @override
  String get threatDevModeMessage =>
      'Developer mode is enabled on this device. Please disable it in your device settings to continue.';

  @override
  String get threatAdbTitle => 'USB Debugging Enabled';

  @override
  String get threatAdbMessage =>
      'USB debugging (ADB) is enabled on this device. Please disable it in Developer Options to continue.';

  @override
  String get threatUnofficialStoreTitle => 'Unofficial Installation Source';

  @override
  String get threatUnofficialStoreMessage =>
      'This app was not installed from an official app store. Please download it from a trusted source.';

  @override
  String get threatScreenshotTitle => 'Screenshot Detected';

  @override
  String get threatScreenshotMessage => 'A screenshot of the app was captured.';

  @override
  String get threatScreenRecordingTitle => 'Screen Recording Detected';

  @override
  String get threatScreenRecordingMessage =>
      'Screen recording is active. Sensitive content may be at risk.';

  @override
  String get threatMalwareTitle => 'Malware Detected';

  @override
  String get threatMalwareMessage =>
      'A potentially malicious application has been detected on this device. Please remove suspicious apps.';

  @override
  String get threatBlockingFooter =>
      'This app cannot continue in this environment.\nPlease resolve the issue and restart.';

  @override
  String get threatCloseApp => 'Close App';

  @override
  String get threatIUnderstand => 'I Understand';

  @override
  String get threatProceedWarning => 'Proceeding may put your data at risk.';

  @override
  String get featureUnderDevelopment => 'This feature is under development';
}
