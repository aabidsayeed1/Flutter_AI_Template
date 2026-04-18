import 'package:flutter_template_2025/core/base/export.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:flutter_template_2025/core/services/permission_service.dart';

import '../../utils/app_toast.dart';

/// Shows a bottom sheet to request a permission with rationale and handles all edge cases.
Future<void> showPermissionRequestBottomSheet({
  required BuildContext context,
  required ph.Permission permission,
  required String rationaleTitle,
  required String rationaleMessage,
  String? deniedMessage,
  String? permanentlyDeniedMessage,
  String? grantButtonText,
  String? settingsButtonText,
  String? cancelButtonText,
  VoidCallback? onGranted,
  VoidCallback? onDenied,
}) async {
  final permissionService = getIt<PermissionService>();

  Future<void> request() async {
    final result = await permissionService.request(permission);
    if (!context.mounted) return;
    if (result.isGranted) {
      Navigator.of(context).pop();
      onGranted?.call();
    } else if (result.isPermanentlyDenied) {
      // Show permanently denied UI
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
            permanentlyDeniedMessage ??
                context.locale.permissionPermanentlyDeniedTitle,
          ),
          content: Text(context.locale.permissionPermanentlyDeniedMessage),
          actions: [
            TextButton(
              onPressed: () async {
                await permissionService.openAppSettings();
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: Text(settingsButtonText ?? context.locale.openSettings),
            ),
            TextButton(
              onPressed: () {
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: Text(cancelButtonText ?? context.locale.cancel),
            ),
          ],
        ),
      );
      if (!context.mounted) return;
      onDenied?.call();
    } else {
      // Show denied UI
      if (context.mounted) {
        context.showError(
          title: deniedMessage ?? context.locale.permissionDeniedTitle,
          message: context.locale.permissionDeniedMessage,
        );
      }
      onDenied?.call();
    }
  }

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
    ),
    builder: (_) => Padding(
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        top: 32.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(rationaleTitle, style: context.textStyle.headlineSmall),
          Gap(16),
          Text(rationaleMessage, style: context.textStyle.bodyMedium),
          Gap(32),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40.h,
                  child: ElevatedButton(
                    onPressed: request,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        grantButtonText ?? context.locale.grantPermission,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textStyle.button.primary.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Gap(16),
              Expanded(
                child: SizedBox(
                  height: 40.h,
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(cancelButtonText ?? context.locale.cancel),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
