import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:injectable/injectable.dart';

/// Service to handle app permissions: request, check, open settings, rationale dialogs.
abstract class PermissionService {
  /// Checks the status of a permission.
  Future<ph.PermissionStatus> check(ph.Permission permission);

  /// Requests a permission and returns the status.
  Future<ph.PermissionStatus> request(ph.Permission permission);

  /// Checks if a rationale should be shown for a permission.
  Future<bool> shouldShowRationale(ph.Permission permission);

  /// Opens the app settings page.
  Future<bool> openAppSettings();
}

/// Implementation of [PermissionService] using permission_handler.
@LazySingleton(as: PermissionService)
class PermissionServiceImpl implements PermissionService {
  @override
  Future<ph.PermissionStatus> check(ph.Permission permission) async {
    return permission.status;
  }

  @override
  Future<ph.PermissionStatus> request(ph.Permission permission) async {
    return permission.request();
  }

  @override
  Future<bool> shouldShowRationale(ph.Permission permission) async {
    return permission.shouldShowRequestRationale;
  }

  @override
  Future<bool> openAppSettings() async {
    return await ph.openAppSettings();
  }
}
