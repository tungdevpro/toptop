import 'package:data/common/api_path.dart';
import 'package:data/datasource/remote/dto/api_response.dart';
import 'package:data/datasource/remote/dto/login/login_request.dart';
import 'package:data/datasource/remote/service/base/base_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthService extends BaseService {
  Future<ApiResponse> performLogin([LoginRequest? body]) async {
    final resp = await api.post(ApiPath.loginEmail, data: body?.toJson());
    return ApiResponse(data: resp);
  }
}
