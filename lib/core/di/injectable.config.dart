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
import 'package:flutter_template_2025/features/authentication/presentation/cubit/auth_cubit.dart'
    as _i1052;
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
    gh.lazySingleton<_i450.LocaleCubit>(() => _i450.LocaleCubit());
    gh.lazySingleton<_i507.ThemeCubit>(() => _i507.ThemeCubit());
    gh.lazySingleton<_i1052.AuthCubit>(
      () => _i1052.AuthCubit(gh<_i460.SharedPreferences>()),
    );
    gh.singleton<_i583.GoRouter>(
      () => routerModule.provideRouter(gh<_i1052.AuthCubit>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i549.RegisterModule {}

class _$RouterModule extends _i454.RouterModule {}
