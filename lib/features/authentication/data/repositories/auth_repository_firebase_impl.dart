import '../../../../core/base/models/failure.dart';
import '../../../../core/services/cache/cache_service.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/entities/sign_up_entity.dart';
import '../../domain/repositories/auth_repository.dart';

// Uncomment @LazySingleton and comment out the one in auth_repository_impl.dart
// to switch to Firebase authentication.
// @LazySingleton(as: AuthRepository)
base class AuthRepositoryFirebaseImpl extends AuthRepository {
  final CacheService cacheService;

  AuthRepositoryFirebaseImpl(this.cacheService);

  @override
  Future<(LoginResponseEntity?, Failure?)> login(LoginRequestEntity data) {
    return asyncGuard(() async {
      // TODO: Implement Firebase sign-in
      // After Firebase auth, return a LoginResponseEntity with the token.
      // The AuthCubit will handle setting the user via UserCubit.
      throw UnimplementedError('Firebase login not implemented');
    });
  }

  @override
  Future<(SignUpResponseEntity?, Failure?)> register(SignUpRequestEntity data) {
    return asyncGuard(() async {
      // TODO: Implement Firebase sign-up
      throw UnimplementedError('Firebase register not implemented');
    });
  }

  @override
  Future<void> logout() async {
    // TODO: Implement Firebase sign-out
    await cacheService.remove([
      CacheKey.accessToken,
      CacheKey.refreshToken,
      CacheKey.isLoggedIn,
    ]);
  }

  @override
  Future<bool> isLoggedIn() async {
    return cacheService.get<bool>(CacheKey.isLoggedIn) ?? false;
  }

  @override
  Future<void> saveRememberMe(RememberMeEntity data) async {
    await cacheService.save(CacheKey.rememberMe, data.enabled);
    if (data.enabled) {
      await cacheService.save(CacheKey.rememberedEmail, data.email ?? '');
      await cacheService.save(CacheKey.rememberedPassword, data.password ?? '');
    } else {
      await cacheService.remove([
        CacheKey.rememberedEmail,
        CacheKey.rememberedPassword,
      ]);
    }
  }

  @override
  Future<RememberMeEntity> getRememberMe() async {
    final enabled = cacheService.get<bool>(CacheKey.rememberMe) ?? false;
    if (!enabled) return const RememberMeEntity();
    return RememberMeEntity(
      enabled: true,
      email: await cacheService.getSecure(CacheKey.rememberedEmail),
      password: await cacheService.getSecure(CacheKey.rememberedPassword),
    );
  }
}
