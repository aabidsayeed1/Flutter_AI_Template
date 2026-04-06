import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../services/connectivity_service.dart';

/// Global cubit that exposes [ConnectivityStatus] to the widget tree.
@lazySingleton
class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  ConnectivityCubit(this._service) : super(_service.currentStatus) {
    _subscription = _service.statusStream.listen(emit);
  }

  final ConnectivityService _service;
  late final StreamSubscription<ConnectivityStatus> _subscription;

  /// Whether the device is currently online.
  bool get isOnline => state == ConnectivityStatus.online;

  /// Manual retry — checks connectivity and emits new state.
  Future<void> checkNow() async {
    await _service.checkNow();
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
