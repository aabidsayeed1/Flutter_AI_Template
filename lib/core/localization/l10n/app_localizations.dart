import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Flutter Template 2025'**
  String get appTitle;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @featured.
  ///
  /// In en, this message translates to:
  /// **'Featured'**
  String get featured;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @createNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Create New password'**
  String get createNewPassword;

  /// No description provided for @createNewPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Your new password must be different from previous used passwords.'**
  String get createNewPasswordHint;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @passwordChangeSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password Changed Successfully'**
  String get passwordChangeSuccess;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @isRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get isRequired;

  /// No description provided for @validEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid email address'**
  String get validEmail;

  /// No description provided for @enterAssociatedEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter the email associated with your account and we’ll send an email with instructions to reset your password.'**
  String get enterAssociatedEmail;

  /// Error message for minimum length validation
  ///
  /// In en, this message translates to:
  /// **'This field must be at least {min} characters long'**
  String minLengthValidation(int min);

  /// Error message for maximum length validation
  ///
  /// In en, this message translates to:
  /// **'This field must be at most {max} characters long'**
  String maxLengthValidation(int max);

  /// No description provided for @yourPasswordChanged.
  ///
  /// In en, this message translates to:
  /// **'Your password has been changed successfully.'**
  String get yourPasswordChanged;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get forgotPassword;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to login'**
  String get backToLogin;

  /// No description provided for @continueAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// No description provided for @checkYourMail.
  ///
  /// In en, this message translates to:
  /// **'Check your mail'**
  String get checkYourMail;

  /// No description provided for @enterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter 4 digit code sent to your mail hello**@gmail.com.'**
  String get enterVerificationCode;

  /// No description provided for @didntGetCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t get a code? '**
  String get didntGetCode;

  /// No description provided for @clickToResend.
  ///
  /// In en, this message translates to:
  /// **'Click to resend'**
  String get clickToResend;

  /// No description provided for @didNotReceiveEmail.
  ///
  /// In en, this message translates to:
  /// **'Did not receive the email? Check your spam filter. or '**
  String get didNotReceiveEmail;

  /// No description provided for @tryAnotherEmail.
  ///
  /// In en, this message translates to:
  /// **'try another email address'**
  String get tryAnotherEmail;

  /// No description provided for @learnFlutterTitle.
  ///
  /// In en, this message translates to:
  /// **'Learn Flutter with comprehensive tutorials.'**
  String get learnFlutterTitle;

  /// No description provided for @learnFlutterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Step-by-step guides for building Flutter apps.'**
  String get learnFlutterSubtitle;

  /// No description provided for @learnFlutterDescription.
  ///
  /// In en, this message translates to:
  /// **'Get notifications for new tutorials and updates.'**
  String get learnFlutterDescription;

  /// No description provided for @joinCommunityTitle.
  ///
  /// In en, this message translates to:
  /// **'Join the Flutter community.'**
  String get joinCommunityTitle;

  /// No description provided for @joinCommunitySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Connect with other Flutter developers.'**
  String get joinCommunitySubtitle;

  /// No description provided for @joinCommunityDescription.
  ///
  /// In en, this message translates to:
  /// **'Participate in community events and discussions.'**
  String get joinCommunityDescription;

  /// No description provided for @buildDeployTitle.
  ///
  /// In en, this message translates to:
  /// **'Build and deploy Flutter apps easily.'**
  String get buildDeployTitle;

  /// No description provided for @buildDeploySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Access tools and resources for app development.'**
  String get buildDeploySubtitle;

  /// No description provided for @buildDeployDescription.
  ///
  /// In en, this message translates to:
  /// **'Deploy your apps to multiple platforms with ease.'**
  String get buildDeployDescription;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @bangla.
  ///
  /// In en, this message translates to:
  /// **'Bangla'**
  String get bangla;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// Error message for password minimum length validation
  ///
  /// In en, this message translates to:
  /// **'Password must be at least {minLength} characters'**
  String passwordMinLengthValidation(String minLength);

  /// No description provided for @passwordNumberValidation.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one number'**
  String get passwordNumberValidation;

  /// No description provided for @passwordLowerCaseValidation.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one lowercase letter'**
  String get passwordLowerCaseValidation;

  /// No description provided for @passwordUpperCaseValidation.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one uppercase letter'**
  String get passwordUpperCaseValidation;

  /// No description provided for @passwordSpecialCharValidation.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one special character'**
  String get passwordSpecialCharValidation;

  /// No description provided for @threatAppIntegrityTitle.
  ///
  /// In en, this message translates to:
  /// **'App Integrity Compromised'**
  String get threatAppIntegrityTitle;

  /// No description provided for @threatAppIntegrityMessage.
  ///
  /// In en, this message translates to:
  /// **'This app has been modified or tampered with. For your security, please download the official version from a trusted store.'**
  String get threatAppIntegrityMessage;

  /// No description provided for @threatObfuscationTitle.
  ///
  /// In en, this message translates to:
  /// **'Security Configuration Issue'**
  String get threatObfuscationTitle;

  /// No description provided for @threatObfuscationMessage.
  ///
  /// In en, this message translates to:
  /// **'The app\'s security configuration is not properly set up. Please contact support.'**
  String get threatObfuscationMessage;

  /// No description provided for @threatDebugTitle.
  ///
  /// In en, this message translates to:
  /// **'Debugging Detected'**
  String get threatDebugTitle;

  /// No description provided for @threatDebugMessage.
  ///
  /// In en, this message translates to:
  /// **'A debugger is attached to this app. For your security, the app cannot run while being debugged.'**
  String get threatDebugMessage;

  /// No description provided for @threatDeviceBindingTitle.
  ///
  /// In en, this message translates to:
  /// **'Device Mismatch'**
  String get threatDeviceBindingTitle;

  /// No description provided for @threatDeviceBindingMessage.
  ///
  /// In en, this message translates to:
  /// **'This app installation has been moved to a different device. Please reinstall the app.'**
  String get threatDeviceBindingMessage;

  /// No description provided for @threatDeviceIdTitle.
  ///
  /// In en, this message translates to:
  /// **'Device ID Compromised'**
  String get threatDeviceIdTitle;

  /// No description provided for @threatDeviceIdMessage.
  ///
  /// In en, this message translates to:
  /// **'The device identifier has been tampered with. The app cannot verify the device integrity.'**
  String get threatDeviceIdMessage;

  /// No description provided for @threatHooksTitle.
  ///
  /// In en, this message translates to:
  /// **'Hooking Framework Detected'**
  String get threatHooksTitle;

  /// No description provided for @threatHooksMessage.
  ///
  /// In en, this message translates to:
  /// **'A hooking framework (e.g., Frida, Xposed) has been detected. The app cannot run in this environment.'**
  String get threatHooksMessage;

  /// No description provided for @threatPasscodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Device Not Secured'**
  String get threatPasscodeTitle;

  /// No description provided for @threatPasscodeMessage.
  ///
  /// In en, this message translates to:
  /// **'Your device does not have a passcode or biometric lock set up. Please secure your device to use this app.'**
  String get threatPasscodeMessage;

  /// No description provided for @threatPrivilegedAccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Rooted/Jailbroken Device'**
  String get threatPrivilegedAccessTitle;

  /// No description provided for @threatPrivilegedAccessMessage.
  ///
  /// In en, this message translates to:
  /// **'This device has been rooted or jailbroken. The app cannot run on compromised devices for your security.'**
  String get threatPrivilegedAccessMessage;

  /// No description provided for @threatSecureHardwareTitle.
  ///
  /// In en, this message translates to:
  /// **'Secure Hardware Unavailable'**
  String get threatSecureHardwareTitle;

  /// No description provided for @threatSecureHardwareMessage.
  ///
  /// In en, this message translates to:
  /// **'This device does not have the required secure hardware. Some security features may not work properly.'**
  String get threatSecureHardwareMessage;

  /// No description provided for @threatSimulatorTitle.
  ///
  /// In en, this message translates to:
  /// **'Emulator/Simulator Detected'**
  String get threatSimulatorTitle;

  /// No description provided for @threatSimulatorMessage.
  ///
  /// In en, this message translates to:
  /// **'This app is running on an emulator or simulator. Please use a real device.'**
  String get threatSimulatorMessage;

  /// No description provided for @threatVpnTitle.
  ///
  /// In en, this message translates to:
  /// **'VPN Detected'**
  String get threatVpnTitle;

  /// No description provided for @threatVpnMessage.
  ///
  /// In en, this message translates to:
  /// **'A system VPN connection has been detected. Please disconnect the VPN to continue.'**
  String get threatVpnMessage;

  /// No description provided for @threatDevModeTitle.
  ///
  /// In en, this message translates to:
  /// **'Developer Mode Enabled'**
  String get threatDevModeTitle;

  /// No description provided for @threatDevModeMessage.
  ///
  /// In en, this message translates to:
  /// **'Developer mode is enabled on this device. Please disable it in your device settings to continue.'**
  String get threatDevModeMessage;

  /// No description provided for @threatAdbTitle.
  ///
  /// In en, this message translates to:
  /// **'USB Debugging Enabled'**
  String get threatAdbTitle;

  /// No description provided for @threatAdbMessage.
  ///
  /// In en, this message translates to:
  /// **'USB debugging (ADB) is enabled on this device. Please disable it in Developer Options to continue.'**
  String get threatAdbMessage;

  /// No description provided for @threatUnofficialStoreTitle.
  ///
  /// In en, this message translates to:
  /// **'Unofficial Installation Source'**
  String get threatUnofficialStoreTitle;

  /// No description provided for @threatUnofficialStoreMessage.
  ///
  /// In en, this message translates to:
  /// **'This app was not installed from an official app store. Please download it from a trusted source.'**
  String get threatUnofficialStoreMessage;

  /// No description provided for @threatScreenshotTitle.
  ///
  /// In en, this message translates to:
  /// **'Screenshot Detected'**
  String get threatScreenshotTitle;

  /// No description provided for @threatScreenshotMessage.
  ///
  /// In en, this message translates to:
  /// **'A screenshot of the app was captured.'**
  String get threatScreenshotMessage;

  /// No description provided for @threatScreenRecordingTitle.
  ///
  /// In en, this message translates to:
  /// **'Screen Recording Detected'**
  String get threatScreenRecordingTitle;

  /// No description provided for @threatScreenRecordingMessage.
  ///
  /// In en, this message translates to:
  /// **'Screen recording is active. Sensitive content may be at risk.'**
  String get threatScreenRecordingMessage;

  /// No description provided for @threatMalwareTitle.
  ///
  /// In en, this message translates to:
  /// **'Malware Detected'**
  String get threatMalwareTitle;

  /// No description provided for @threatMalwareMessage.
  ///
  /// In en, this message translates to:
  /// **'A potentially malicious application has been detected on this device. Please remove suspicious apps.'**
  String get threatMalwareMessage;

  /// No description provided for @threatBlockingFooter.
  ///
  /// In en, this message translates to:
  /// **'This app cannot continue in this environment.\nPlease resolve the issue and restart.'**
  String get threatBlockingFooter;

  /// No description provided for @threatCloseApp.
  ///
  /// In en, this message translates to:
  /// **'Close App'**
  String get threatCloseApp;

  /// No description provided for @threatIUnderstand.
  ///
  /// In en, this message translates to:
  /// **'I Understand'**
  String get threatIUnderstand;

  /// No description provided for @threatProceedWarning.
  ///
  /// In en, this message translates to:
  /// **'Proceeding may put your data at risk.'**
  String get threatProceedWarning;

  /// No description provided for @featureUnderDevelopment.
  ///
  /// In en, this message translates to:
  /// **'This feature is under development'**
  String get featureUnderDevelopment;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
