// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_template_2025/core/di/register_modules.dart' as _i549;
import 'package:flutter_template_2025/core/localization/locale_cubit.dart'
    as _i450;
import 'package:flutter_template_2025/core/router/router.dart' as _i454;
import 'package:flutter_template_2025/core/theme/theme_cubit.dart' as _i507;
import 'package:flutter_template_2025/features/authentication/data/datasources/auth_remote_data_source.dart'
    as _i220;
import 'package:flutter_template_2025/features/authentication/data/datasources/auth_remote_data_source_firebase.dart'
    as _i888;
import 'package:flutter_template_2025/features/authentication/data/repositories/auth_repository_impl.dart'
    as _i72;
import 'package:flutter_template_2025/features/authentication/domain/repositories/auth_repository.dart'
    as _i337;
import 'package:flutter_template_2025/features/authentication/domain/use_cases/get_auth_status_usecase.dart'
    as _i310;
import 'package:flutter_template_2025/features/authentication/domain/use_cases/login_usecase.dart'
    as _i685;
import 'package:flutter_template_2025/features/authentication/domain/use_cases/logout_usecase.dart'
    as _i900;
import 'package:flutter_template_2025/features/authentication/domain/use_cases/observe_auth_state_usecase.dart'
    as _i789;
import 'package:flutter_template_2025/features/authentication/presentation/cubit/auth_cubit.dart'
    as _i1052;
import 'package:flutter_template_2025/features/home/data/datasources/home_remote_data_source.dart'
    as _i800;
import 'package:flutter_template_2025/features/home/data/datasources/home_remote_data_source_impl.dart'
    as _i379;
import 'package:flutter_template_2025/features/home/data/repositories/home_repository_impl.dart'
    as _i337;
import 'package:flutter_template_2025/features/home/domain/repositories/home_repository.dart'
    as _i61;
import 'package:flutter_template_2025/features/home/domain/use_cases/get_home_items_usecase.dart'
    as _i968;
import 'package:flutter_template_2025/features/home/presentation/bloc/home_bloc.dart'
    as _i731;
import 'package:flutter_template_2025/features/profile/data/datasources/profile_remote_data_source.dart'
    as _i491;
import 'package:flutter_template_2025/features/profile/data/datasources/profile_remote_data_source_impl.dart'
    as _i273;
import 'package:flutter_template_2025/features/profile/data/repositories/profile_repository_impl.dart'
    as _i606;
import 'package:flutter_template_2025/features/profile/domain/repositories/profile_repository.dart'
    as _i276;
import 'package:flutter_template_2025/features/profile/domain/use_cases/get_profile_usecase.dart'
    as _i530;
import 'package:flutter_template_2025/features/profile/presentation/cubit/profile_cubit.dart'
    as _i117;
import 'package:get_it/get_it.dart' as _i174;
import 'package:go_router/go_router.dart' as _i583;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    final routerModule = _$RouterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i507.ThemeCubit>(() => _i507.ThemeCubit());
    gh.lazySingleton<_i450.LocaleCubit>(
      () => _i450.LocaleCubit(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i220.AuthRemoteDataSource>(
      () => _i888.FirebaseAuthRemoteDataSource(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i800.HomeRemoteDataSource>(
      () => _i379.HomeRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i491.ProfileRemoteDataSource>(
      () => _i273.ProfileRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i276.ProfileRepository>(
      () => _i606.ProfileRepositoryImpl(gh<_i491.ProfileRemoteDataSource>()),
    );
    gh.lazySingleton<_i337.AuthRepository>(
      () => _i72.AuthRepositoryImpl(gh<_i220.AuthRemoteDataSource>()),
    );
    gh.lazySingleton<_i61.HomeRepository>(
      () => _i337.HomeRepositoryImpl(gh<_i800.HomeRemoteDataSource>()),
    );
    gh.factory<_i968.GetHomeItemsUseCase>(
      () => _i968.GetHomeItemsUseCase(gh<_i61.HomeRepository>()),
    );
    gh.factory<_i530.GetProfileUseCase>(
      () => _i530.GetProfileUseCase(gh<_i276.ProfileRepository>()),
    );
    gh.factory<_i310.GetAuthStatusUseCase>(
      () => _i310.GetAuthStatusUseCase(gh<_i337.AuthRepository>()),
    );
    gh.factory<_i685.LoginUseCase>(
      () => _i685.LoginUseCase(gh<_i337.AuthRepository>()),
    );
    gh.factory<_i900.LogoutUseCase>(
      () => _i900.LogoutUseCase(gh<_i337.AuthRepository>()),
    );
    gh.factory<_i789.ObserveAuthStateUseCase>(
      () => _i789.ObserveAuthStateUseCase(gh<_i337.AuthRepository>()),
    );
    gh.factory<_i731.HomeBloc>(
      () => _i731.HomeBloc(gh<_i968.GetHomeItemsUseCase>()),
    );
    gh.lazySingleton<_i1052.AuthCubit>(
      () => _i1052.AuthCubit(
        gh<_i789.ObserveAuthStateUseCase>(),
        gh<_i900.LogoutUseCase>(),
        gh<_i685.LoginUseCase>(),
      ),
    );
    gh.lazySingleton<_i117.ProfileCubit>(
      () => _i117.ProfileCubit(gh<_i530.GetProfileUseCase>()),
    );
    gh.singleton<_i583.GoRouter>(
      () => routerModule.provideRouter(gh<_i1052.AuthCubit>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i549.RegisterModule {}

class _$RouterModule extends _i454.RouterModule {}
