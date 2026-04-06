import '../../base/export.dart';
import '../../connectivity/connectivity_cubit.dart';
import '../../services/connectivity_service.dart';

/// Persistent "No internet" banner that slides in/out above page content.
class NoInternetBanner extends StatelessWidget {
  const NoInternetBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, ConnectivityStatus>(
      builder: (context, status) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return SizeTransition(
              sizeFactor: animation,
              axisAlignment: -1,
              child: child,
            );
          },
          child: status == ConnectivityStatus.offline
              ? Material(
                  color: context.color.error,
                  child: Container(
                    key: const ValueKey('offline-banner'),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    child: SafeArea(
                      bottom: false,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.wifi_off_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                          Gap(8.w),
                          Expanded(
                            child: Text(
                              context.locale.offlineMode,
                              style: context.textStyle.bodySmall.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<ConnectivityCubit>().checkNow();
                            },
                            child: Text(
                              context.locale.retryConnection,
                              style: context.textStyle.bodySmall.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(key: ValueKey('online')),
        );
      },
    );
  }
}
