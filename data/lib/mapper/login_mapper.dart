import 'package:data/datasource/remote/dto/login/login_request.dart';
import 'package:data/datasource/remote/dto/login/login_response.dart';
import 'package:domain/model/login_model.dart';
import 'package:domain/model/login_request_model.dart';

extension LoginRequestExts on LoginRequestModel {
  LoginRequest toModel() => LoginRequest(email: email, password: password);
}

extension LoginModelExts on LoginResponse {
  LoginModel toModel() => LoginModel(token: accessToken);
}
