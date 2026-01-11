import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/use_cases/logout_usecase.dart';
import '../../domain/use_cases/observe_auth_state_usecase.dart';

part 'auth_state.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  final ObserveAuthStateUseCase observeAuthState;
  final LogoutUseCase logoutUseCase;
  static const _key = 'logged_in';

  final SharedPreferences prefs;

  AuthCubit(this.prefs, this.observeAuthState, this.logoutUseCase)
    : super(const AuthState.unknown()) {
    _loadAuthState();
    _listenAuthState();
  }

  // ✅ Loads previous login state on app startup
  void _loadAuthState() async {
    await Future.delayed(const Duration(seconds: 2)); // simulate splash delay
    final bool error = Random().nextBool(); // simulate random error
    if (error) {
      emit(const AuthState.error('Failed to load auth state'));
      return;
    }
    final isLoggedIn = prefs.getBool(_key) ?? false;
    if (isLoggedIn) {
      emit(const AuthState.authenticated());
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  // ✅ LOGIN (persisted)
  Future<void> login() async {
    await prefs.setBool(_key, true);
    emit(const AuthState.authenticated());
  }

  // ✅ LOGOUT (persisted)
  Future<void> logout() async {
    await prefs.setBool(_key, false);
    emit(const AuthState.unauthenticated());
  }

  // ✅ RETRY
  Future<void> retry() async {
    emit(const AuthState.unknown());
    _loadAuthState();
  }

  void _listenAuthState() {
    observeAuthState().listen((user) {
      if (user != null) {
        // pass the user data if needed
        emit(AuthState.authenticated());
      } else {
        emit(const AuthState.unauthenticated());
      }
    });
  }

  Future<void> remoteLogout() async {
    await logoutUseCase();
  }
}
