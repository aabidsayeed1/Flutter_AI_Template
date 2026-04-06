import 'dart:async';

import '../../base/export.dart';
import '../../connectivity/connectivity_cubit.dart';
import '../../logger/log.dart';
import '../../router/router.dart';
import '../../router/routes.dart';
import '../../services/app_route_observer.dart';
import '../../services/connectivity_service.dart';
import '../../utils/app_toast.dart';
import 'no_internet_banner.dart';

/// Wraps page content and reacts to connectivity + route changes.
///
/// **Modes:** toast, banner, blocked (bottom sheet), none.
class ConnectivityWrapper extends StatefulWidget {
  const ConnectivityWrapper({
    super.key,
    required this.child,
    this.defaultMode = ConnectivityDisplayMode.toast,
  });

  final Widget child;

  /// Fallback mode for routes without a specific configuration.
  final ConnectivityDisplayMode defaultMode;

  @override
  State<ConnectivityWrapper> createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  late final StreamSubscription<ConnectivityStatus> _connectivitySub;
  bool _wasOffline = false;
  bool _bottomSheetOpen = false;

  ConnectivityService get _service => getIt<ConnectivityService>();
  AppRouteObserver get _routeObserver => getIt<AppRouteObserver>();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ConnectivityCubit>();
    _wasOffline = !cubit.isOnline;

    _connectivitySub = cubit.stream.listen(_onConnectivityChange);
    _routeObserver.currentRoute.addListener(_onRouteChange);
  }

  ConnectivityDisplayMode get _currentMode {
    final route = _routeObserver.currentRoute.value;
    return _service.getRouteMode(route) ?? widget.defaultMode;
  }

  void _onRouteChange() {
    if (!mounted) return;
    final mode = _currentMode;
    Log.debug(
      'ConnectivityWrapper: route=${_routeObserver.currentRoute.value}, '
      'mode=${mode.name}',
    );

    final isOffline =
        context.read<ConnectivityCubit>().state == ConnectivityStatus.offline;

    if (mode == ConnectivityDisplayMode.blocked && isOffline) {
      _showBlockedSheet();
    }

    if (mode != ConnectivityDisplayMode.blocked && _bottomSheetOpen) {
      _dismissBlockedSheet();
    }
  }

  // ── Connectivity change ───────────────────────────────────────────

  void _onConnectivityChange(ConnectivityStatus status) {
    if (!mounted) return;

    final mode = _currentMode;
    Log.debug('ConnectivityWrapper: status=${status.name}, mode=${mode.name}');

    if (mode == ConnectivityDisplayMode.blocked) {
      if (status == ConnectivityStatus.offline) {
        _showBlockedSheet();
      } else {
        _dismissBlockedSheet();
      }
    } else if (mode == ConnectivityDisplayMode.toast ||
        mode == ConnectivityDisplayMode.banner) {
      if (status == ConnectivityStatus.offline) {
        context.showError(
          title: context.locale.noInternetConnection,
          message: context.locale.noInternetMessage,
        );
        _wasOffline = true;
      } else if (_wasOffline) {
        context.showSuccess(title: context.locale.connectionRestored);
        _wasOffline = false;
      }
    } else {
      _wasOffline = status == ConnectivityStatus.offline;
    }
  }

  // ── Bottom sheet helpers ──────────────────────────────────────────

  void _showBlockedSheet() {
    if (_bottomSheetOpen) return;

    final navigator = rootNavigatorKey.currentState;
    if (navigator == null) return;

    _bottomSheetOpen = true;

    showModalBottomSheet<void>(
      context: navigator.context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _BlockedBottomSheet(
        onBack: () {
          _dismissBlockedSheet();
          final router = getIt<GoRouter>();
          if (router.canPop()) {
            router.pop();
          } else {
            router.go(Routes.home);
          }
        },
        onRetry: () async {
          await context.read<ConnectivityCubit>().checkNow();
        },
      ),
    ).whenComplete(() {
      _bottomSheetOpen = false;
    });
  }

  void _dismissBlockedSheet() {
    if (!_bottomSheetOpen) return;
    final navigator = rootNavigatorKey.currentState;
    if (navigator != null && navigator.canPop()) {
      navigator.pop();
    }
  }

  // ── Lifecycle ─────────────────────────────────────────────────────

  @override
  void dispose() {
    _connectivitySub.cancel();
    _routeObserver.currentRoute.removeListener(_onRouteChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, ConnectivityStatus>(
      buildWhen: (prev, curr) => _currentMode == ConnectivityDisplayMode.banner,
      builder: (context, status) {
        if (_currentMode == ConnectivityDisplayMode.banner &&
            status == ConnectivityStatus.offline) {
          return Column(
            children: [
              const NoInternetBanner(),
              Expanded(child: widget.child),
            ],
          );
        }
        return widget.child;
      },
    );
  }
}

// ── Blocked bottom sheet content ──────────────────────────────────────

class _BlockedBottomSheet extends StatelessWidget {
  const _BlockedBottomSheet({required this.onBack, required this.onRetry});

  final VoidCallback onBack;
  final Future<void> Function() onRetry;

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
                  Icons.wifi_off_rounded,
                  size: 56.sp,
                  color: context.color.error,
                ),
                Gap(16.h),
                Text(
                  context.locale.noInternetConnection,
                  style: context.textStyle.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                Gap(8.h),
                Text(
                  context.locale.noInternetMessage,
                  style: context.textStyle.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                Gap(24.h),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onBack,
                        icon: const Icon(Icons.arrow_back),
                        label: Text(context.locale.goBack),
                      ),
                    ),
                    Gap(12.w),
                    Expanded(
                      child: BlocBuilder<ConnectivityCubit, ConnectivityStatus>(
                        builder: (context, status) {
                          return FilledButton.icon(
                            onPressed: onRetry,
                            icon: const Icon(Icons.refresh),
                            label: Text(context.locale.retryConnection),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
