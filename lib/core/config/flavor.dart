enum Flavor { dev, qa, uat, prod }

/// Flavor configuration management
/// Handles environment-specific settings for different build flavors
class F {
  static late final Flavor appFlavor;

  /// Flavor name (dev, qa, uat, prod)
  static String get name => appFlavor.name;

  /// Display title for the app
  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Flutter Template Dev';
      case Flavor.qa:
        return 'Flutter Template QA';
      case Flavor.uat:
        return 'Flutter Template UAT';
      case Flavor.prod:
        return 'Flutter Template';
    }
  }

  /// Base API URL for the current flavor
  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.dev:
        return 'https://dummyjson.com';
      case Flavor.qa:
        return 'https://qa-api.example.com';
      case Flavor.uat:
        return 'https://uat-api.example.com';
      case Flavor.prod:
        return 'https://api.example.com';
    }
  }

  /// API timeout duration per flavor
  static Duration get apiTimeout {
    switch (appFlavor) {
      case Flavor.dev:
      case Flavor.qa:
        return const Duration(seconds: 60); // Longer timeout for debugging
      case Flavor.uat:
      case Flavor.prod:
        return const Duration(seconds: 30);
    }
  }

  /// Feature flags - Analytics enabled
  static bool get enableAnalytics {
    switch (appFlavor) {
      case Flavor.dev:
        return false; // Disabled in dev
      case Flavor.qa:
      case Flavor.uat:
      case Flavor.prod:
        return true;
    }
  }

  /// Feature flags - Crash reporting enabled
  static bool get enableCrashReporting {
    switch (appFlavor) {
      case Flavor.dev:
      case Flavor.qa:
        return false; // Disabled in lower environments
      case Flavor.uat:
      case Flavor.prod:
        return true;
    }
  }

  /// Feature flags - Debug logging enabled
  static bool get enableDebugLogging {
    switch (appFlavor) {
      case Flavor.dev:
        return true;
      case Flavor.qa:
        return true;
      case Flavor.uat:
        return false;
      case Flavor.prod:
        return false;
    }
  }

  /// Feature flags - Mock data enabled
  static bool get useMockData {
    return appFlavor == Flavor.dev;
  }

  /// Check if running in development environment
  static bool get isDev => appFlavor == Flavor.dev;

  /// Check if running in QA environment
  static bool get isQA => appFlavor == Flavor.qa;

  /// Check if running in UAT environment
  static bool get isUAT => appFlavor == Flavor.uat;

  /// Check if running in production environment
  static bool get isProd => appFlavor == Flavor.prod;

  /// Check if running in non-production environment
  static bool get isNonProd =>
      appFlavor == Flavor.dev ||
      appFlavor == Flavor.qa ||
      appFlavor == Flavor.uat;

  /// Get color for flavor (for UI indicators)
  static String get flavorColor {
    switch (appFlavor) {
      case Flavor.dev:
        return '#2196F3'; // Blue
      case Flavor.qa:
        return '#FF9800'; // Orange
      case Flavor.uat:
        return '#9C27B0'; // Purple
      case Flavor.prod:
        return '#4CAF50'; // Green
    }
  }

  /// Get flavor badge text with environment info
  static String get flavorBadge => F.name.toUpperCase();

  /// Maximum retry attempts per flavor
  static int get maxRetryAttempts {
    switch (appFlavor) {
      case Flavor.dev:
      case Flavor.qa:
        return 3;
      case Flavor.uat:
      case Flavor.prod:
        return 2;
    }
  }

  /// Cache duration per flavor
  static Duration get cacheDuration {
    switch (appFlavor) {
      case Flavor.dev:
        return const Duration(minutes: 5);
      case Flavor.qa:
      case Flavor.uat:
        return const Duration(minutes: 15);
      case Flavor.prod:
        return const Duration(hours: 1);
    }
  }

  /// Enable network interceptor logging
  static bool get enableNetworkLogging => isNonProd;

  /// Enable local notifications
  static bool get enableNotifications => !isDev;

  /// Log tag for current flavor
  static String get logTag => '[${F.name.toUpperCase()}]';

  /// Description of current flavor for debugging
  static String get description =>
      '''
Flavor: ${F.name}
Title: ${F.title}
Base URL: ${F.baseUrl}
API Timeout: ${F.apiTimeout.inSeconds}s
Analytics: ${F.enableAnalytics}
Crash Reporting: ${F.enableCrashReporting}
Debug Logging: ${F.enableDebugLogging}
Mock Data: ${F.useMockData}
  ''';
}
