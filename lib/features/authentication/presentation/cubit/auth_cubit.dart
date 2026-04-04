import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/logger/log.dart';
import '../../../../core/user/user_cubit.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/entities/remember_me_entity.dart';
import '../../domain/entities/sign_up_entity.dart';
import '../../domain/use_cases/login_usecase.dart';
import '../../domain/use_cases/logout_usecase.dart';
import '../../domain/use_cases/remember_me_usecase.dart';
import '../../domain/use_cases/sign_up_usecase.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  final LogoutUseCase logoutUseCase;
  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;
  final UserCubit userCubit;
  final RememberMeUseCase rememberMeUseCase;

  AuthCubit(
    this.logoutUseCase,
    this.loginUseCase,
    this.signUpUseCase,
    this.userCubit,
    this.rememberMeUseCase,
  ) : super(const AuthState()) {
    _checkAuthStatus();
  }

  // ── LOGIN ──────────────────────────────────────────────────────────────
  Future<void> login({
    required String username,
    required String password,
    bool rememberMe = false,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading, error: null));
    final data = LoginRequestEntity(
      username: username,
      password: password,
      shouldRemeber: rememberMe,
    );
    final (response, failure) = await loginUseCase(data);
    if (failure != null) {
      Log.debug('Login Failed : ${failure.message}');
      emit(state.copyWith(status: AuthStatus.error, error: failure.message));
      return;
    }
    if (response != null) {
      _setUserFromLoginResponse(response);
    }

    // Save remember me with credentials
    await rememberMeUseCase.save(
      RememberMeEntity(
        enabled: rememberMe,
        email: rememberMe ? username : null,
        password: rememberMe ? password : null,
      ),
    );

    Log.debug('Logged in — token: ${response?.accessToken}');
    emit(state.copyWith(status: AuthStatus.authenticated, error: null));
  }

  // ── SIGN UP ────────────────────────────────────────────────────────────
  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading, error: null));
    final data = SignUpRequestEntity(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );
    final (response, failure) = await signUpUseCase(data);
    if (failure != null) {
      emit(state.copyWith(status: AuthStatus.error, error: failure.message));
      return;
    }
    Log.debug('Signed up — token: ${response?.accessToken}');
    emit(state.copyWith(status: AuthStatus.authenticated, error: null));
  }

  // ── LOGOUT ─────────────────────────────────────────────────────────────
  Future<void> logout() async {
    await logoutUseCase();
    userCubit.clearUser();
    emit(state.copyWith(status: AuthStatus.unauthenticated, error: null));
  }

  // ── RETRY ──────────────────────────────────────────────────────────────
  Future<void> retry() async {
    emit(state.copyWith(status: AuthStatus.unknown, error: null));
    _checkAuthStatus();
  }

  // ── CHECK AUTH STATUS ON START ─────────────────────────────────────────
  void _checkAuthStatus() {
    userCubit.loadFromCache();
    if (userCubit.user != null) {
      emit(state.copyWith(status: AuthStatus.authenticated));
    } else {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }

  // ── MAP LOGIN RESPONSE TO USER ─────────────────────────────────────────
  void _setUserFromLoginResponse(LoginResponseEntity response) {
    userCubit.setUser(response.toUser());
  }

  // ── REMEMBER ME ────────────────────────────────────────────────────────
  Future<RememberMeEntity> getRememberMe() => rememberMeUseCase.get();
}
