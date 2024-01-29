import 'package:domain/common/result.dart';
import 'package:domain/model/login_model.dart';
import 'package:domain/model/login_request_model.dart';
import 'package:domain/repository/login_repository.dart';
import 'package:domain/usecase/login/login_use_case.dart';
import 'package:injectable/injectable.dart';

@named
@Injectable(as: LoginUseCase)
class LoginUseCaseImpl extends LoginUseCase {
  final LoginRepository _repository;

  LoginUseCaseImpl(this._repository);

  @override
  Future<Result<LoginModel>> performLogin(LoginRequestModel model) {
    return _repository.performLogin(model);
  }
}
