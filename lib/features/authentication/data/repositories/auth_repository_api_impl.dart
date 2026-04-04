import 'package:injectable/injectable.dart';

import '../../../../core/base/models/failure.dart';
import '../../../../core/services/cache/cache_service.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/entities/sign_up_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/login_model.dart';
import '../models/sign_up_model.dart';
import '../services/network/auth_api.dart';

@LazySingleton(as: AuthRepository)
final class AuthRepositoryApiImpl extends AuthRepository {
  final AuthApi api;
  final CacheService cacheService;

  AuthRepositoryApiImpl(this.api, this.cacheService);

  @override
  Future<(LoginResponseEntity?, Failure?)> login(LoginRequestEntity data) {
    return asyncGuard(() async {
      final model = LoginRequestModel.fromEntity(data);
      final response = await api.login(model);

      // Parse response — response.data is already a Map (Dio auto-decodes JSON)
      final loginResponse = LoginResponseModelMapper.fromMap(response.data);

      // Save tokens
      await cacheService.save(CacheKey.accessToken, loginResponse.accessToken);
      await cacheService.save(
        CacheKey.refreshToken,
        loginResponse.refreshToken,
      );
      await cacheService.save(CacheKey.isLoggedIn, true);

      return loginResponse;
    });
  }

  @override
  Future<(SignUpResponseEntity?, Failure?)> register(SignUpRequestEntity data) {
    return asyncGuard(() async {
      final response = await api.register(data.toJson());
      return SignUpResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    });
  }

  @override
  Future<void> logout() async {
    await cacheService.remove([
      CacheKey.accessToken,
      CacheKey.refreshToken,
      CacheKey.isLoggedIn,
      CacheKey.user,
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
      email: cacheService.get<String>(CacheKey.rememberedEmail),
      password: cacheService.get<String>(CacheKey.rememberedPassword),
    );
  }
}
