import 'package:data/di/locator.dart';
import 'package:data/network/dio_client.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ApiClient {
  ApiClient() {
    _client = locator<DioClient>()..init();
  }

  late DioClient _client;
}
