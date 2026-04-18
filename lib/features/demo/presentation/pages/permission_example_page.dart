import 'package:flutter_template_2025/core/base/export.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import '../../../../core/utils/app_toast.dart';
import '../../../../core/widgets/permission/permission_request_bottom_sheet.dart';

class PermissionExamplePage extends StatelessWidget {
  const PermissionExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.locale.permissionRationaleTitle)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await showPermissionRequestBottomSheet(
                    context: context,
                    permission: ph.Permission.camera,
                    rationaleTitle: context.locale.permissionRationaleTitle,
                    rationaleMessage: context.locale.permissionRationaleMessage,
                    deniedMessage: context.locale.permissionDeniedMessage,
                    permanentlyDeniedMessage:
                        context.locale.permissionPermanentlyDeniedMessage,
                    grantButtonText: context.locale.grantPermission,
                    settingsButtonText: context.locale.openSettings,
                    cancelButtonText: context.locale.cancel,
                    onGranted: () => context.showSuccess(
                      title: 'Camera permission granted!',
                    ),
                    onDenied: null,
                  );
                },
                child: Text('Request Camera Permission'),
              ),
              Gap(16),
              ElevatedButton(
                onPressed: () async {
                  await showPermissionRequestBottomSheet(
                    context: context,
                    permission: ph.Permission.photos,
                    rationaleTitle: 'Photo Library Permission',
                    rationaleMessage:
                        'This app needs access to your photos to upload and save media.',
                    deniedMessage: 'Photo library permission denied.',
                    permanentlyDeniedMessage:
                        'Photo library permission permanently denied.',
                    grantButtonText: 'Grant Photo Access',
                    settingsButtonText: context.locale.openSettings,
                    cancelButtonText: context.locale.cancel,
                    onGranted: () => context.showSuccess(
                      title: 'Photo library permission granted!',
                    ),
                    onDenied: null,
                  );
                },
                child: Text('Request Photo Permission'),
              ),
              Gap(16),
              ElevatedButton(
                onPressed: () async {
                  await showPermissionRequestBottomSheet(
                    context: context,
                    permission: ph.Permission.location,
                    rationaleTitle: 'Location Permission',
                    rationaleMessage:
                        'This app needs your location to provide location-based features.',
                    deniedMessage: 'Location permission denied.',
                    permanentlyDeniedMessage:
                        'Location permission permanently denied.',
                    grantButtonText: 'Grant Location Access',
                    settingsButtonText: context.locale.openSettings,
                    cancelButtonText: context.locale.cancel,
                    onGranted: () => context.showSuccess(
                      title: 'Location permission granted!',
                    ),
                    onDenied: null,
                  );
                },
                child: Text('Request Location Permission'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
