part of '../router.dart';

StatefulShellRoute _shellRoutes() {
  return StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return NavigationShell(statefulNavigationShell: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: Routes.home,
            name: Routes.home,
            pageBuilder: (context, state) {
              return const MaterialPage(child: HomePage());
            },
            routes: [
              GoRoute(
                path: 'profile',
                name: 'profile',
                pageBuilder: (context, state) {
                  return const MaterialPage(child: ProfilePage());
                },
              ),
            ],
          ),

          GoRoute(
            path: Routes.profile1,
            name: Routes.profile1,
            pageBuilder: (context, state) {
              return const MaterialPage(child: ProfilePage());
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: Routes.profile,
            name: Routes.profile,
            pageBuilder: (context, state) {
              return const MaterialPage(child: ProfilePage());
            },
          ),
        ],
      ),
    ],
  );
}
