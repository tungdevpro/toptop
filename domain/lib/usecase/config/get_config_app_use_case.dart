import 'package:domain/common/result.dart';
import 'package:domain/model/config_model.dart';
import 'package:domain/usecase/base_use_case.dart';

abstract class GetConfigAppUseCase extends BaseUseCase {
  Future<Result<ConfigModel>> getConfig();
}
