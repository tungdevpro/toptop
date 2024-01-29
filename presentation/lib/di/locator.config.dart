// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:domain/usecase/config/get_config_app_use_case.dart' as _i9;
import 'package:domain/usecase/login/login_use_case.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../core/app/app_bloc.dart' as _i8;
import '../core/auth/bloc/auth_bloc.dart' as _i3;
import '../features/home/bloc/home_bloc.dart' as _i4;
import '../features/login/bloc/login_bloc.dart' as _i5;
import '../features/register/bloc/register_bloc.dart' as _i7;
import '../import.dart' as _i10;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt initPresentation({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.AuthBloc>(_i3.AuthBloc());
    gh.factory<_i4.HomeBloc>(() => _i4.HomeBloc());
    gh.factory<_i5.LoginBloc>(() => _i5.LoginBloc(gh<_i6.LoginUseCase>(instanceName: 'LoginUseCaseImpl')));
    gh.factory<_i7.RegisterBloc>(() => _i7.RegisterBloc());
    gh.singleton<_i8.AppBloc>(_i8.AppBloc(
      gh<_i9.GetConfigAppUseCase>(),
      gh<_i10.AuthBloc>(),
    ));
    return this;
  }
}
