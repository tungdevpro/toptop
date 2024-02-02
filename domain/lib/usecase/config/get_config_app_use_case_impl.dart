import 'package:domain/common/result.dart';
import 'package:domain/model/config_model.dart';
import 'package:domain/repository/app_repository.dart';
import 'package:domain/usecase/config/get_config_app_use_case.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GetConfigAppUseCase)
class GetConfigAppUseCaseImpl extends GetConfigAppUseCase {
  final ConfigRepository repository;
  GetConfigAppUseCaseImpl(this.repository);

  @override
  Future<Result<ConfigModel>> getConfig() async {
    return repository.fetch();
  }
}
