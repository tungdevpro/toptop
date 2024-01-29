import 'package:data/common/api_path.dart';
import 'package:data/datasource/remote/dto/api_response.dart';
import 'package:data/datasource/remote/service/base/base_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppService extends BaseService {
  Future<ApiResponse> getConfig() async {
    return (await api.get(ApiPath.config));
  }
}
