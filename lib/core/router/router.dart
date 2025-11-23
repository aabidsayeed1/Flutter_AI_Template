import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../features/authentication/presentation/cubit/auth_cubit.dart';
import '../../features/authentication/presentation/forgot_password/view/create_new_password_page.dart';
import '../../features/authentication/presentation/forgot_password/view/email_verification_page.dart';
import '../../features/authentication/presentation/forgot_password/view/reset_password_page.dart';
import '../../features/authentication/presentation/forgot_password/view/reset_password_success_page.dart';
import '../../features/authentication/presentation/login/view/login_page.dart';
import '../../features/authentication/presentation/registration/view/registration_page.dart';
import '../../features/home/view/home_page.dart';
import '../../features/onboarding/view/onboarding_page.dart';
import '../../features/profile/view/profile_page.dart';
import '../../features/splash/view/splash_page.dart';
import '../../widgets/app_startup/startup_widget.dart';
import '../../widgets/navigation_shell.dart' show NavigationShell;
import '../logger/log.dart';
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

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Root');

@module
abstract class RouterModule {
  @singleton
  GoRouter provideRouter(AuthCubit authCubit) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
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
        final onboarded = true; // from SharedPrefs
        final splashDone = true; // splash completed

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
}
