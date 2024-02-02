// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../repository/app_repository.dart' as _i5;
import '../repository/login_repository.dart' as _i8;
import '../usecase/config/get_config_app_use_case.dart' as _i3;
import '../usecase/config/get_config_app_use_case_impl.dart' as _i4;
import '../usecase/login/login_use_case.dart' as _i6;
import '../usecase/login/login_use_case_impl.dart' as _i7;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt initDomain({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.GetConfigAppUseCase>(
        () => _i4.GetConfigAppUseCaseImpl(gh<_i5.ConfigRepository>()));
    gh.factory<_i6.LoginUseCase>(
      () => _i7.LoginUseCaseImpl(gh<_i8.LoginRepository>()),
      instanceName: 'LoginUseCaseImpl',
    );
    return this;
  }
}
