import 'package:data/repository/base/base_repository.dart';
import 'package:domain/common/result.dart';
import 'package:domain/model/login_model.dart';
import 'package:domain/model/login_request_model.dart';
import 'package:domain/repository/login_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl extends BaseRepository implements LoginRepository {
  @override
  Future<Result<LoginModel>> performLogin(LoginRequestModel model) {
    throw UnimplementedError();
  }
}
