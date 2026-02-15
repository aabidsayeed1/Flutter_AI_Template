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
  GoRouter provideRouter(AuthCubit authCubit) {
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      refreshListenable: GoRouterRefreshStream(authCubit.stream.distinct()),
      debugLogDiagnostics: true,
      initialLocation: Routes.initial,
      redirect: (context, state) {
        //  redirect: (context, state) {
        //   final auth = authCubit.state;

        //   // WAIT until auth state is ready
        //   if (auth.isUnknown) return null;

        //   final loggedIn = auth.isLoggedIn;
        // final goingToLogin = state.matchedLocation == Routes.login;

        //   if (!loggedIn && !goingToLogin) return Routes.login;
        //   if (loggedIn && goingToLogin) return Routes.home;

        //   return null;
        // },

        // Log.info('Redirecting to ${state.uri}');
        final auth = authCubit.state;
        final loggedIn = auth.isLoggedIn;
        final isUnknown = auth.isUnknown;
        final error = auth.error != null;
        final onboarded = _isOnboarded(); // from SharedPrefs
        final splashDone = _isSplashDone(); // splash completed

        final goingTo = state.uri.path;
        if (isUnknown || error) {
          return null;
        }
        // ✅ 1. While splash not done, always stay on splash
        if (!splashDone && goingTo != Routes.splash) {
          return Routes.splash;
        }

        // ✅ 2. On first install → force onboarding
        if (splashDone && !onboarded && goingTo != Routes.onboarding) {
          return Routes.onboarding;
        }

        // ✅ 3. If not logged in → only allow login + auth-related pages
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
        // ✅ 4. If logged in → prevent going back to login or onboarding
        if (loggedIn &&
            (goingTo == Routes.login ||
                goingTo == Routes.onboarding ||
                goingTo == Routes.initial)) {
          return Routes.home;
        }

        return null; // ✅
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
  }

  bool _isOnboarded() {
    // TODO: Replace with SharedPrefs or storage read
    return true;
  }

  bool _isSplashDone() {
    // TODO: Replace with splash completion flag
    return true;
  }
}
