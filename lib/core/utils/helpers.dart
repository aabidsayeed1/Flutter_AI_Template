import 'dart:async';

/// General helper functions
class Helpers {
  /// Safely executes a function and returns result or null on error
  static T? executeWithSafety<T>(
    T Function() function, {
    void Function(dynamic error)? onError,
  }) {
    try {
      return function();
    } catch (e) {
      onError?.call(e);
      return null;
    }
  }

  /// Executes function with retry logic
  static Future<T> executeWithRetry<T>(
    Future<T> Function() function, {
    int maxRetries = 3,
    Duration delayBetweenRetries = const Duration(seconds: 1),
  }) async {
    int attempts = 0;
    while (true) {
      try {
        return await function();
      } catch (e) {
        attempts++;
        if (attempts >= maxRetries) {
          rethrow;
        }
        await Future.delayed(delayBetweenRetries);
      }
    }
  }

  /// Debounces function execution
  static void Function() debounce(void Function() function, Duration duration) {
    Timer? timer;
    return () {
      timer?.cancel();
      timer = Timer(duration, function);
    };
  }

  /// Throttles function execution
  static void Function() throttle(void Function() function, Duration duration) {
    DateTime? lastExecutedTime;
    return () {
      final now = DateTime.now();
      if (lastExecutedTime == null ||
          now.difference(lastExecutedTime!).inMilliseconds >
              duration.inMilliseconds) {
        function();
        lastExecutedTime = now;
      }
    };
  }

  /// Checks if list is empty or null
  static bool isEmptyOrNull(List? list) {
    return list == null || list.isEmpty;
  }

  /// Checks if map is empty or null
  static bool isMapEmptyOrNull(Map? map) {
    return map == null || map.isEmpty;
  }

  /// Safely accesses nested map value
  static T? safeAccess<T>(
    Map<String, dynamic>? map,
    String key, {
    T? defaultValue,
  }) {
    try {
      return map?[key] ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  /// Generates unique ID
  static String generateUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  /// Checks if string is a valid URL
  static bool isValidUrl(String url) {
    try {
      Uri.parse(url);
      return url.startsWith('http://') || url.startsWith('https://');
    } catch (e) {
      return false;
    }
  }
}
