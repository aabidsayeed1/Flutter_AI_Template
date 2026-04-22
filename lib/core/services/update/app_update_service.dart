import 'package:flutter_template_2025/core/index.dart';

/// Represents update/maintenance info returned by the backend or remote config.
class UpdateInfo {
  final bool forceUpdate;
  final bool maintenanceMode;
  final bool featureBlocked;
  final String? featureRoute;
  final String? updateTitle;
  final String? updateMessage;
  final String? updateUrl;
  final String? maintenanceTitle;
  final String? maintenanceMessage;
  final String? appVersion; // Target users with <= this version

  const UpdateInfo({
    this.forceUpdate = false,
    this.maintenanceMode = false,
    this.featureBlocked = false,
    this.featureRoute,
    this.updateTitle,
    this.updateMessage,
    this.updateUrl,
    this.maintenanceTitle,
    this.maintenanceMessage,
    this.appVersion,
  });
}

/// Singleton implementation for update/maintenance logic.
class AppUpdateService {
  static final AppUpdateService instance = AppUpdateService._();
  AppUpdateService._();

  final List<UpdateInfo> _updateInfoList = [];

  Future<void> initialize() async {
    // In real implementation, fetch from API or remote config
    // For stub, nothing to do
    if (_updateInfoList.isEmpty) {
      _updateInfoList.addAll([
        UpdateInfo(
          featureBlocked: false,
          forceUpdate: false,
          featureRoute: '/demo',
          appVersion: '1.0.0',
          updateTitle: 'Update Required',
          updateMessage: 'A new version is available for Demo. Please update.',
          updateUrl: 'https://example.com/update',
        ),
        UpdateInfo(
          maintenanceMode: true,
          featureRoute: '/demo',
          appVersion: '1.0.0',
          maintenanceTitle: 'Maintenance',
          maintenanceMessage: 'Demo is under maintenance.',
        ),
      ]);
    }
    Log.info(
      'AppUpdateService initialized with ${_updateInfoList.length} entries',
    );
  }

  List<UpdateInfo> getUpdateInfoList() {
    return _updateInfoList;
  }

  /// Returns true if any force update is required for the current version.
  bool isAnyForceUpdate(String currentVersion) {
    return _updateInfoList.any(
      (info) =>
          info.forceUpdate &&
          (info.appVersion == null ||
              currentVersion.compareTo(info.appVersion!) <= 0),
    );
  }

  /// Returns the first maintenance info for the given route and version, or null.
  UpdateInfo? getMaintenanceForRoute(String route, String currentVersion) {
    for (final info in _updateInfoList) {
      if (info.maintenanceMode &&
          info.featureRoute == route &&
          (info.appVersion == null ||
              currentVersion.compareTo(info.appVersion!) <= 0)) {
        return info;
      }
    }
    return null;
  }

  /// Returns the first featureBlocked info for the given route and version, or null.
  UpdateInfo? getFeatureBlockedForRoute(String route, String currentVersion) {
    for (final info in _updateInfoList) {
      if (info.featureBlocked &&
          info.featureRoute == route &&
          (info.appVersion == null ||
              currentVersion.compareTo(info.appVersion!) <= 0)) {
        return info;
      }
    }
    return null;
  }

  /// Returns true if any featureBlocked is present for the current version (for home update prompt).
  bool hasFeatureBlocked(String currentVersion) {
    return _updateInfoList.any(
      (info) =>
          info.featureBlocked &&
          (info.appVersion == null ||
              currentVersion.compareTo(info.appVersion!) <= 0),
    );
  }

  /// Returns true if the route should be blocked (maintenance or featureBlocked).
  bool shouldBlockRoute(String route, String currentVersion) {
    return getMaintenanceForRoute(route, currentVersion) != null ||
        getFeatureBlockedForRoute(route, currentVersion) != null;
  }

  /// Returns true if navigation to the route should be blocked (for router guards).
  /// Blocks if force update is required (blocks all routes), or if the route is under maintenance or featureBlocked.
  bool shouldBlockNavigation(String route, String currentVersion) {
    // Block navigation to this route if maintenance or featureBlocked
    return shouldBlockRoute(route, currentVersion);
  }
}
