import 'package:flutter_template_2025/core/services/app_info_service.dart';
import 'package:store_redirect/store_redirect.dart';
import '../../base/export.dart';
import '../../utils/app_toast.dart';

class ForceUpdateBottomSheet extends StatelessWidget {
  const ForceUpdateBottomSheet({super.key});

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
                Icon(
                  Icons.system_update,
                  size: 56.sp,
                  color: context.color.primary,
                ),
                Gap(16.h),
                Text(
                  context.locale.forceUpdateTitle,
                  style: context.textStyle.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                Gap(8.h),
                Text(
                  context.locale.forceUpdateMessage,
                  style: context.textStyle.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                Gap(24.h),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      final androidAppId = AppInfoService.instance.androidAppId;
                      final iOSAppId = AppInfoService.instance.iOSAppId;
                      try {
                        StoreRedirect.redirect(
                          androidAppId: androidAppId,
                          iOSAppId: iOSAppId,
                        );
                      } catch (e) {
                        context.showError(
                          title: context.locale.redirectFailedTitle,
                          message: context.locale.redirectFailedMessage,
                        );
                      }
                    },
                    child: Text(context.locale.updateNow),
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
