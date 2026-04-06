import 'package:flutter/foundation.dart';
import 'package:toastification/toastification.dart';

import 'core/base/export.dart';
import 'core/config/app_initializer.dart';
import 'core/config/flavor.dart';
import 'core/connectivity/connectivity_cubit.dart';
import 'core/theme/theme_cubit.dart';
import 'core/widgets/connectivity/connectivity_wrapper.dart';

// This variable is automatically set by Flutter when running with --flavor
// If not set, it defaults to 'dev'
const String appFlavor = String.fromEnvironment('flavor', defaultValue: 'dev');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize flavors
  try {
    F.appFlavor = Flavor.values.firstWhere(
      (element) => element.name == appFlavor,
    );
  } catch (e) {
    // Default to dev if flavor not found
    F.appFlavor = Flavor.dev;
  }

  // Initialize dependency injection
  await configureDependencies();

  // Initialize all third-party SDKs and services
  await AppInitializer.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: getIt<LocaleCubit>()),
          BlocProvider.value(value: getIt<ThemeCubit>()),
          BlocProvider.value(value: getIt<ConnectivityCubit>()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          bloc: getIt<ThemeCubit>(),
          builder: (context, themeMode) {
            return BlocBuilder<LocaleCubit, Locale>(
              bloc: getIt<LocaleCubit>(),
              builder: (context, locale) {
                return ScreenUtilInit(
                  designSize: const Size(375, 812),
                  minTextAdapt: true,
                  splitScreenMode: true,
                  builder: (context, child) {
                    return MaterialApp.router(
                      title: F.title,
                      debugShowCheckedModeBanner: false,
                      theme: context.lightTheme,
                      darkTheme: context.darkTheme,
                      themeMode: themeMode,
                      locale: locale,
                      localizationsDelegates: const [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      supportedLocales: AppLocalizations.supportedLocales,
                      routerConfig: getIt<GoRouter>(),
                      builder: (context, child) {
                        Widget result = child ?? const SizedBox();

                        // Global connectivity: route-aware mode resolution
                        result = ConnectivityWrapper(child: result);

                        // Show flavor banner in debug mode
                        if (kDebugMode) {
                          result = Banner(
                            location: BannerLocation.topStart,
                            message: F.name.toUpperCase(),
                            color: _getFlavorColor(),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0,
                              letterSpacing: 1.0,
                              color: Colors.white,
                            ),
                            textDirection: TextDirection.ltr,
                            child: result,
                          );
                        }
                        return result;
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Color _getFlavorColor() {
    switch (F.appFlavor) {
      case Flavor.dev:
        return Colors.green;
      case Flavor.qa:
        return Colors.orange;
      case Flavor.uat:
        return Colors.blue;
      case Flavor.prod:
        return Colors.red;
    }
  }
}
