import 'package:domain/common/result.dart';
import 'package:domain/model/login_model.dart';
import 'package:domain/model/login_request_model.dart';
import 'package:domain/usecase/base_use_case.dart';

abstract class LoginUseCase implements BaseUseCase {
  Future<Result<LoginModel>> performLogin(LoginRequestModel model);
}
