import 'package:data/datasource/remote/service/auth_service.dart';
import 'package:data/mapper/login_mapper.dart';
import 'package:data/repository/base/base_repository.dart';
import 'package:domain/common/result.dart';
import 'package:domain/model/login_model.dart';
import 'package:domain/model/login_request_model.dart';
import 'package:domain/repository/login_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl extends BaseRepository implements LoginRepository {
  final AuthService _authService;
  LoginRepositoryImpl(this._authService);

  @override
  Future<Result<LoginModel>> performLogin(LoginRequestModel model) async {
    return apiCall(_authService.performLogin(model.toModel()), mapper: (response) => response?.toModel());
  }
}
