import 'package:data/network/dio_client.dart';

abstract class DioClientFactory {
  static DioClient create([String? baseUrl]) {
    var client = DioClient()..init(baseUrl: baseUrl);
    return client;
  }
}
