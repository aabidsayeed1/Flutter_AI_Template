/// App-wide configuration and metadata
class AppConfig {
  // App metadata
  static const String appName = 'Flutter Template 2025';
  static const String packageName = 'com.example.flutter_template_2025';

  // API Configuration - Update based on environment
  static const String baseUrl = 'https://api.example.com';
  static const Duration apiTimeout = Duration(seconds: 30);

  // Feature flags
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const bool enableLogging = true;
}
