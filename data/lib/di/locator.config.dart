// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:domain/repository/app_repository.dart' as _i8;
import 'package:domain/repository/login_repository.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../datasource/remote/service/app_service.dart' as _i3;
import '../datasource/remote/service/auth_service.dart' as _i4;
import '../network/dio_client.dart' as _i5;
import '../repository/app_repository_impl.dart' as _i9;
import '../repository/login_repository_impl.dart' as _i7;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt initData({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.AppService>(() => _i3.AppService());
    gh.lazySingleton<_i4.AuthService>(() => _i4.AuthService());
    gh.singleton<_i5.DioClient>(_i5.DioClient());
    gh.factory<_i6.LoginRepository>(
        () => _i7.LoginRepositoryImpl(gh<_i4.AuthService>()));
    gh.factory<_i8.AppRepository>(
        () => _i9.AppRepositoryImpl(gh<_i3.AppService>()));
    return this;
  }
}
