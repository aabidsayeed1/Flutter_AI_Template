import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../logger/log.dart';

/// Global route observer that exposes the current route via [currentRoute].
///
/// Services (ScreenProtection, Connectivity, Analytics, etc.) listen to
/// [currentRoute] independently — no need to modify this class when
/// adding new route-aware features.
class AppRouteObserver extends NavigatorObserver {
  AppRouteObserver();

  GoRouter? _router;
  Timer? _debounceTimer;

  /// Single source of truth for the current route path.
  final ValueNotifier<String> currentRoute = ValueNotifier('');

  void attachRouter(GoRouter router) {
    _router = router;
    router.routerDelegate.addListener(_onRouteChange);
  }

  void _onRouteChange() {
    final r = _router;
    if (r == null) return;

    // Debounce: routerDelegate fires multiple times per navigation.
    // Only the first post-frame callback reads the correct pushed route.
    if (_debounceTimer?.isActive == true) return;
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {});

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final location = r.routeInformationProvider.value.uri.toString();
      Log.debug('AppRouteObserver: $location');
      currentRoute.value = location;
    });
  }
}
