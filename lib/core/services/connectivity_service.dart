import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../index.dart';

/// Connectivity status combining network type + actual internet reachability.
enum ConnectivityStatus { online, offline }

/// Display mode for connectivity feedback per route.
enum ConnectivityDisplayMode {
  /// Shows a toast on disconnect/reconnect (least intrusive).
  toast,

  /// Shows a persistent banner below the status bar.
  banner,

  /// Blocks the entire page with a full-screen "No Internet" overlay.
  blocked,

  /// No automatic UI — app handles it manually.
  none,
}

/// Centralized connectivity service.
///
/// Uses [connectivity_plus] for fast detection and
/// [internet_connection_checker_plus] for actual reachability.
@lazySingleton
class ConnectivityService {
  ConnectivityService() {
    _init();
  }

  final Connectivity _connectivity = Connectivity();
  final InternetConnection _internetChecker = InternetConnection();

  final _statusController = StreamController<ConnectivityStatus>.broadcast();
  ConnectivityStatus _currentStatus = ConnectivityStatus.online;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySub;
  StreamSubscription<InternetStatus>? _internetSub;

  /// Stream of connectivity status changes. Only emits on actual changes.
  Stream<ConnectivityStatus> get statusStream => _statusController.stream;

  /// Current connectivity status (synchronous).
  ConnectivityStatus get currentStatus => _currentStatus;

  /// Whether the device is currently online.
  bool get isOnline => _currentStatus == ConnectivityStatus.online;

  // ── Route-based display mode ───────────────────────────────────────

  /// Exact-match route → display mode.
  static final Map<String, ConnectivityDisplayMode> _routeModes = {
    // Examples:
    Routes.profile: ConnectivityDisplayMode.blocked,
    // Routes.home: ConnectivityDisplayMode.banner,
  };

  /// Prefix-match route → display mode. Matches the route and all children.
  static final Map<String, ConnectivityDisplayMode> _routeModePrefixes = {
    '${Routes.login}/${Routes.registration}': ConnectivityDisplayMode.blocked,
  };

  /// Returns the configured mode for [route], or `null` for default.
  ConnectivityDisplayMode? getRouteMode(String route) {
    // 1. Exact match first
    final exact = _routeModes[route];
    if (exact != null) return exact;

    // 2. Prefix match
    for (final entry in _routeModePrefixes.entries) {
      if (route == entry.key || route.startsWith('${entry.key}/')) {
        return entry.value;
      }
    }

    return null;
  }

  // ── Lifecycle ──────────────────────────────────────────────────────

  void _init() async {
    bool firstConnectivityEventHandled = false;
    _connectivitySub = _connectivity.onConnectivityChanged.listen((results) {
      Log.info('Connectivity changed: $results');
      // On iOS, the first event can be [none] even if online. Ignore it.
      if (!firstConnectivityEventHandled) {
        firstConnectivityEventHandled = true;
        return;
      }
      final hasNetwork = !results.contains(ConnectivityResult.none);
      if (!hasNetwork) {
        _updateStatus(ConnectivityStatus.offline);
      }
    });

    _internetSub = _internetChecker.onStatusChange.listen((status) {
      switch (status) {
        case InternetStatus.connected:
          _updateStatus(ConnectivityStatus.online);
        case InternetStatus.disconnected:
          _updateStatus(ConnectivityStatus.offline);
      }
    });

    _checkInitialStatus();
  }

  Future<void> _checkInitialStatus() async {
    final hasInternet = await _internetChecker.hasInternetAccess;
    _updateStatus(
      hasInternet ? ConnectivityStatus.online : ConnectivityStatus.offline,
    );
  }

  void _updateStatus(ConnectivityStatus newStatus) {
    if (_currentStatus == newStatus) return;
    _currentStatus = newStatus;
    _statusController.add(newStatus);
    Log.info('Connectivity: ${newStatus.name}');
  }

  /// Manual connectivity check — useful for retry buttons.
  Future<bool> checkNow() async {
    final hasInternet = await _internetChecker.hasInternetAccess;
    _updateStatus(
      hasInternet ? ConnectivityStatus.online : ConnectivityStatus.offline,
    );
    return hasInternet;
  }

  @disposeMethod
  void dispose() {
    _connectivitySub?.cancel();
    _internetSub?.cancel();
    _statusController.close();
  }
}
