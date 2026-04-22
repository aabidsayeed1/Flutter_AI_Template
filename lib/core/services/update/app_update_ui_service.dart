import 'package:flutter/material.dart';
import 'package:flutter_template_2025/core/services/app_info_service.dart';
import 'package:flutter_template_2025/core/services/update/app_update_service.dart';
import 'package:flutter_template_2025/core/widgets/update/feature_blocked_bottom_sheet.dart';
import 'package:flutter_template_2025/core/widgets/update/home_update_bottom_sheet.dart';

import '../../di/injectable.dart';
import '../../widgets/update/force_update_bottom_sheet.dart';
import '../../widgets/update/maintenance_bottom_sheet.dart';
import '../cache/cache_service.dart';

class AppUpdateUIService {
  static bool _bottomSheetOpen = false;

  static void showIfNeeded(BuildContext context, String route) {
    final currentVersion = AppInfoService.instance.version;
    final updateService = AppUpdateService.instance;
    final cacheService = getIt<CacheService>();

    // 1. Force Update: block everywhere, non-dismissible
    if (updateService.isAnyForceUpdate(currentVersion)) {
      _showForceUpdateSheet(context);
      return;
    }

    // 2. Maintenance: block only on the route, dismissible
    final maintenanceInfo = updateService.getMaintenanceForRoute(
      route,
      currentVersion,
    );
    if (maintenanceInfo != null) {
      if (_bottomSheetOpen) return;
      _bottomSheetOpen = true;
      showModalBottomSheet<void>(
        context: context,
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => MaintenanceBottomSheet(info: maintenanceInfo),
      ).whenComplete(() => _bottomSheetOpen = false);
      return;
    }

    // 3. Feature Blocked: block only on the route, dismissible
    final featureBlockedInfo = updateService.getFeatureBlockedForRoute(
      route,
      currentVersion,
    );
    if (featureBlockedInfo != null) {
      _showFeatureBlockedSheet(context, featureBlockedInfo);
      return;
    }

    // 4. Home route update prompt: show if any featureBlocked exists
    if (route == '/home' && updateService.hasFeatureBlocked(currentVersion)) {
      final dismissedVersion = cacheService.get<String>(
        CacheKey.homeUpdateDismissedVersion,
      );
      if (dismissedVersion == currentVersion) {
        return;
      }
      _showHomeUpdateSheet(context, cacheService, currentVersion);
      return;
    }
  }

  static void _showForceUpdateSheet(BuildContext context) {
    if (_bottomSheetOpen) return;
    _bottomSheetOpen = true;
    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const ForceUpdateBottomSheet(),
    ).whenComplete(() => _bottomSheetOpen = false);
  }

  static void _showFeatureBlockedSheet(BuildContext context, UpdateInfo info) {
    if (_bottomSheetOpen) return;
    _bottomSheetOpen = true;
    showModalBottomSheet<void>(
      context: context,
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FeatureBlockedBottomSheet(info: info),
    ).whenComplete(() => _bottomSheetOpen = false);
  }

  static void _showHomeUpdateSheet(
    BuildContext context,
    CacheService cacheService,
    String currentVersion,
  ) {
    if (_bottomSheetOpen) return;
    _bottomSheetOpen = true;
    showModalBottomSheet<void>(
      context: context,
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => HomeUpdateBottomSheet(
        onClose: () {
          cacheService.save<String>(
            CacheKey.homeUpdateDismissedVersion,
            currentVersion,
          );
        },
      ),
    ).whenComplete(() => _bottomSheetOpen = false);
  }
}
