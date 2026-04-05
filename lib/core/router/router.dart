import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../features/authentication/presentation/cubit/auth_cubit.dart';
import '../../features/authentication/presentation/forgot_password/pages/create_new_password_page.dart';
import '../../features/authentication/presentation/forgot_password/pages/email_verification_page.dart';
import '../../features/authentication/presentation/forgot_password/pages/reset_password_page.dart';
import '../../features/authentication/presentation/forgot_password/pages/reset_password_success_page.dart';
import '../../features/authentication/presentation/login/page/login_page.dart';
import '../../features/authentication/presentation/registration/pages/registration_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../core/widgets/splash/splash_page.dart';
import '../../core/widgets/app_startup/app_startup_widget.dart';
import '../../core/widgets/navigation_shell.dart' show NavigationShell;
import '../services/cache/cache_service.dart';
import '../services/security/screen_protection_observer.dart';
import 'routes.dart';

part 'parts/authentication_routes.dart';
part 'parts/on_boarding_routes.dart';
part 'parts/shell_routes.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.isBroadcast
        ? stream.listen((_) => notifyListeners())
        : stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

/// Global navigator key accessible for Dio interceptors (e.g. [TokenManager]).
final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Root');

@module
abstract class RouterModule {
  @singleton
  GoRouter provideRouter(AuthCubit authCubit, CacheService cacheService) {
    final screenProtectionObserver = ScreenProtectionObserver();

    final router = GoRouter(
      navigatorKey: rootNavigatorKey,
      refreshListenable: GoRouterRefreshStream(authCubit.stream.distinct()),
      debugLogDiagnostics: true,
      initialLocation: Routes.initial,
      redirect: (context, state) {
        final auth = authCubit.state;
        final goingTo = state.uri.path;

        // ⏳ Wait for auth to settle — splash (AppStartupWidget) stays
        // visible at "/" until auth emits authenticated/unauthenticated.
        if (auth.status == AuthStatus.unknown ||
            auth.status == AuthStatus.loading) {
          return null;
        }

        final loggedIn = auth.status == AuthStatus.authenticated;
        final onboarded =
            cacheService.get<bool>(CacheKey.isOnBoardingCompleted) ?? false;

        // ✅ 1. Not onboarded → must complete onboarding first
        if (!onboarded) {
          return goingTo == Routes.onboarding ? null : Routes.onboarding;
        }

        // — Below: user IS onboarded —

        // ✅ 2. Not logged in → only allow public (auth) pages
        if (!loggedIn) {
          final publicPages = {
            state.namedLocation(Routes.login),
            state.namedLocation(Routes.registration),
            state.namedLocation(Routes.resetPassword),
            state.namedLocation(Routes.emailVerification),
            state.namedLocation(Routes.createNewPassword),
            state.namedLocation(Routes.resetPasswordSuccess),
          };

          if (!publicPages.contains(goingTo)) {
            return Routes.login;
          }
        }

        // ✅ 3. Logged in → prevent going back to auth/setup pages
        if (loggedIn &&
            (goingTo == Routes.login ||
                goingTo == Routes.onboarding ||
                goingTo == Routes.initial ||
                goingTo == Routes.splash)) {
          return Routes.home;
        }

        return null;
      },
      routes: [
        GoRoute(
          path: Routes.initial,
          name: Routes.initial,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: AppStartupWidget());
          },
        ),
        ..._onboardingRoutes(),
        ..._authenticationRoutes(),
        _shellRoutes(),
      ],
    );

    screenProtectionObserver.attachRouter(router);
    return router;
  }
}
