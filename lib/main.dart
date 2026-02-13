import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'core/base/export.dart';
import 'core/config/flavor.dart';
import 'core/theme/theme_cubit.dart';

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

  // Set preferred orientations (optional)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<LocaleCubit>()),
        BlocProvider.value(value: getIt<ThemeCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        bloc: getIt<ThemeCubit>(),
        builder: (context, themeMode) {
          return BlocBuilder<LocaleCubit, Locale>(
            bloc: getIt<LocaleCubit>(),
            builder: (context, locale) {
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
                  // Show flavor banner in debug mode
                  if (kDebugMode) {
                    return Banner(
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
                      child: child ?? const SizedBox(),
                    );
                  }
                  return child ?? const SizedBox();
                },
              );
            },
          );
        },
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
