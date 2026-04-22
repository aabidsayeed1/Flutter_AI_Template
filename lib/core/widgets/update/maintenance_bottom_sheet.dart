import '../../base/export.dart';
import '../../services/update/app_update_service.dart';

class MaintenanceBottomSheet extends StatelessWidget {
  final UpdateInfo info;
  const MaintenanceBottomSheet({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.color.scaffoldBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: context.color.disabled,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              children: [
                Icon(Icons.build, size: 56.sp, color: context.color.error),
                Gap(16.h),
                Text(
                  info.maintenanceTitle ?? context.locale.maintenanceTitle,
                  style: context.textStyle.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                Gap(8.h),
                Text(
                  info.maintenanceMessage ?? context.locale.maintenanceMessage,
                  style: context.textStyle.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                Gap(24.h),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(context.locale.close),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
