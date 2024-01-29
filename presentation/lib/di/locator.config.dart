// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:domain/usecase/config/get_config_app_use_case.dart' as _i11;
import 'package:domain/usecase/login/login_use_case.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../core/app/app_bloc.dart' as _i10;
import '../core/auth/bloc/auth_bloc.dart' as _i3;
import '../features/camera/bloc/camera_bloc.dart' as _i4;
import '../features/home/bloc/home_bloc.dart' as _i5;
import '../features/login/bloc/login_bloc.dart' as _i6;
import '../features/profile/bloc/profile_bloc.dart' as _i8;
import '../features/register/bloc/register_bloc.dart' as _i9;
import '../import.dart' as _i12;

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
    gh.factory<_i4.CameraBloc>(() => _i4.CameraBloc());
    gh.factory<_i5.HomeBloc>(() => _i5.HomeBloc());
    gh.factory<_i6.LoginBloc>(() =>
        _i6.LoginBloc(gh<_i7.LoginUseCase>(instanceName: 'LoginUseCaseImpl')));
    gh.factory<_i8.ProfileBloc>(() => _i8.ProfileBloc());
    gh.factory<_i9.RegisterBloc>(() => _i9.RegisterBloc());
    gh.singleton<_i10.AppBloc>(_i10.AppBloc(
      gh<_i11.GetConfigAppUseCase>(),
      gh<_i12.AuthBloc>(),
    ));
    return this;
  }
}
