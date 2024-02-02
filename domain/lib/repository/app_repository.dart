import 'package:domain/common/result.dart';
import 'package:domain/model/config_model.dart';

abstract class ConfigRepository {
  Future<Result<ConfigModel>> fetch();
}
