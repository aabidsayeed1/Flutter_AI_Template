import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/authentication/data/services/network/auth_api.dart';
import '../../features/authentication/data/services/network/auth_endpoints.dart';
import '../config/flavor.dart';
import '../router/router.dart';
import '../services/cache/cache_service.dart';
import '../services/interceptor/token_manager.dart';

@module
abstract class RegisterModule {
  // ─── SharedPreferences ────────────────────────────────────────────────
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  // ─── CacheService ────────────────────────────────────────────────────
  @lazySingleton
  CacheService cacheService(SharedPreferences prefs) =>
      SharedPreferencesService(prefs);

  // ─── Dio ─────────────────────────────────────────────────────────────
  /// Main [Dio] instance used across the app.
  /// Includes [TokenManager] for automatic token injection & refresh,
  /// and [PrettyDioLogger] in debug mode.
  @lazySingleton
  Dio dio(CacheService cacheService) {
    final dio = Dio(
      BaseOptions(
        baseUrl: F.baseUrl,
        connectTimeout: F.apiTimeout,
        receiveTimeout: F.apiTimeout,
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // Token interceptor — handles auth header & 401 refresh
    dio.interceptors.add(
      TokenManager(
        baseUrl: F.baseUrl,
        refreshTokenEndpoint: AuthEndpoints.refreshToken,
        cacheService: cacheService,
        navigatorKey: rootNavigatorKey,
        // Separate Dio for token refresh to avoid interceptor recursion
        dio: Dio(
          BaseOptions(
            baseUrl: F.baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        ),
      ),
    );

    // Pretty logger — only in debug mode
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
        ),
      );
    }

    return dio;
  }

  // ─── Feature API Clients (Retrofit) ──────────────────────────────────
  // Each feature gets its own @RestApi client, all sharing the same Dio.
  // Add new feature APIs here (e.g., HomeApi, ProfileApi).

  @lazySingleton
  AuthApi authApi(Dio dio) => AuthApi(dio);
}
