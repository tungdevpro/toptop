import 'package:data/common/api_path.dart';
import 'package:data/datasource/remote/dto/api_model.dart';
import 'package:data/datasource/remote/dto/register/create_account_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dto/register/register_request.dart';

part 'register_service.g.dart';

@RestApi()
abstract class RegisterService {
  factory RegisterService(Dio dio) = _RegisterService;

  @POST(ApiPath.registerEmail)
  Future<ApiModel<CreateAccountResponse>> perform(@Body() RegisterRequest model);
}
