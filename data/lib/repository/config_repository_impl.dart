import 'package:data/repository/base/base_repository.dart';
import 'package:domain/common/result.dart';
import 'package:domain/model/config_model.dart';
import 'package:domain/repository/app_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ConfigRepository)
class ConfigRepositoryImpl extends BaseRepository implements ConfigRepository {
  @override
  Future<Result<ConfigModel>> fetch() {
    throw UnimplementedError();
  }
}
