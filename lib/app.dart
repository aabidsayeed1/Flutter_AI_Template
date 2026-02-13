import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'core/config/flavor.dart';
import 'core/di/injectable.dart';
import 'core/services/navigation_service.dart';
import 'pages/my_home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: F.title,
      theme: ThemeData(primarySwatch: Colors.blue),
      navigatorKey: getIt<NavigationService>().navigatorKey,
      home: _flavorBanner(
        child: MyHomePage(),
        show:
            kDebugMode &&
            F.isNonProd, // Only show banner in non-prod debug mode
      ),
    );
  }

  /// Displays a flavor banner in debug mode for non-production builds
  Widget _flavorBanner({required Widget child, bool show = true}) {
    if (!show) return child;

    return Banner(
      location: BannerLocation.topStart,
      message: F.flavorBadge,
      color: _hexToColor(F.flavorColor),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 12.0,
        letterSpacing: 1.0,
        color: Colors.white,
      ),
      textDirection: TextDirection.ltr,
      child: child,
    );
  }

  /// Converts hex color string to Color
  Color _hexToColor(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor'; // Add opacity
    }
    return Color(int.parse('0x$hexColor'));
  }
}
