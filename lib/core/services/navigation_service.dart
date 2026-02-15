import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../router/router.dart';

/// Provides global access to the navigator state.
/// Uses the same [rootNavigatorKey] that [GoRouter] uses.
@lazySingleton
class NavigationService {
  GlobalKey<NavigatorState> get navigatorKey => rootNavigatorKey;

  BuildContext? get currentContext => navigatorKey.currentContext;

  NavigatorState? get navigator => navigatorKey.currentState;
}
