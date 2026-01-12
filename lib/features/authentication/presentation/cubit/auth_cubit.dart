import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template_2025/features/authentication/domain/use_cases/login_usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/logger/log.dart';
import '../../domain/entities/user.dart';
import '../../domain/use_cases/logout_usecase.dart';
import '../../domain/use_cases/observe_auth_state_usecase.dart';

part 'auth_state.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  final ObserveAuthStateUseCase observeAuthState;
  final LogoutUseCase logoutUseCase;
  final LoginUseCase loginUseCase;
  AuthCubit(this.observeAuthState, this.logoutUseCase, this.loginUseCase)
    : super(const AuthState.unknown()) {
    _listenAuthState();
  }

  // ✅ LOGIN (persisted)
  Future<void> login() async {
    final user = await loginUseCase(
      email: 'user@example.com',
      password: 'password',
    );
    if (user == null) {
      emit(const AuthState.error('Login failed'));
      return;
    }
    Log.debug('Logged in user: ${user.email}');
    emit(AuthState.authenticated(user: user));
  }

  // ✅ LOGOUT (persisted)
  Future<void> logout() async {
    await logoutUseCase();
    emit(const AuthState.unauthenticated());
  }

  // ✅ RETRY
  Future<void> retry() async {
    emit(const AuthState.unknown());
    _listenAuthState();
  }

  void _listenAuthState() async {
    await Future.delayed(const Duration(seconds: 2)); // simulate splash delay
    final bool error = Random().nextBool(); // simulate random error
    if (error) {
      emit(const AuthState.error('Failed to load auth state'));
      return;
    }
    observeAuthState().listen((user) {
      Log.debug('listenAuthState: ${user?.email}');
      if (user != null) {
        emit(AuthState.authenticated(user: user));
      } else {
        emit(const AuthState.unauthenticated());
      }
    });
  }
}
