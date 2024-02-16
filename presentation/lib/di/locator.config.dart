// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:domain/usecase/config/get_config_app_use_case.dart' as _i12;
import 'package:domain/usecase/login/login_use_case.dart' as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../core/app/app_bloc.dart' as _i11;
import '../core/auth/bloc/auth_bloc.dart' as _i3;
import '../features/camera/bloc/camera_bloc.dart' as _i4;
import '../features/feed/bloc/feed_bloc.dart' as _i5;
import '../features/home/bloc/home_bloc.dart' as _i6;
import '../features/login/bloc/login_bloc.dart' as _i7;
import '../features/profile/bloc/profile_bloc.dart' as _i9;
import '../features/register/bloc/register_bloc.dart' as _i10;
import '../import.dart' as _i13;

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
    gh.factory<_i5.FeedBloc>(() => _i5.FeedBloc());
    gh.factory<_i6.HomeBloc>(() => _i6.HomeBloc());
    gh.factory<_i7.LoginBloc>(() =>
        _i7.LoginBloc(gh<_i8.LoginUseCase>(instanceName: 'LoginUseCaseImpl')));
    gh.factory<_i9.ProfileBloc>(() => _i9.ProfileBloc());
    gh.factory<_i10.RegisterBloc>(() => _i10.RegisterBloc());
    gh.singleton<_i11.AppBloc>(_i11.AppBloc(
      gh<_i12.GetConfigAppUseCase>(),
      gh<_i13.AuthBloc>(),
    ));
    return this;
  }
}
