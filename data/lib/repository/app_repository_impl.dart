import 'package:data/datasource/remote/service/app_service.dart';
import 'package:domain/common/result.dart';

import 'package:domain/model/config_model.dart';
import 'package:injectable/injectable.dart';

import 'base/base_repository.dart';
import 'package:domain/repository/app_repository.dart';

@Injectable(as: AppRepository)
class AppRepositoryImpl extends BaseRepository implements AppRepository {
  final AppService _service;
  AppRepositoryImpl(this._service);

  @override
  Future<Result<ConfigModel>> getConfig() async {
    return apiCall(_service.getConfig(), mapper: (data) => ConfigModel.fromJson(data));
  }
}
