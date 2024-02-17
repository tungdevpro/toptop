import 'package:domain/common/result.dart';
import 'package:domain/model/config_model.dart';
import 'package:domain/usecase/config/get_config_app_use_case.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GetConfigAppUseCase)
class GetConfigAppFromFirebaseUseCaseImpl extends GetConfigAppUseCase {
  @override
  Future<Result<ConfigModel>> getConfig() {
    throw UnimplementedError();
  }
}
