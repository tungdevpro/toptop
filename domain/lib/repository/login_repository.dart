import '../common/result.dart';
import '../model/login_model.dart';
import '../model/login_request_model.dart';

abstract class LoginRepository {
  Future<Result<LoginModel>> performLogin(LoginRequestModel model);
}
