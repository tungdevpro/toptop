import 'package:data/network/dio_client.dart';
import 'package:data/network/dio_client_factory.dart';

abstract class BaseService {
  final String? baseUrl;
  late DioClient api;
  BaseService({this.baseUrl}) {
    api = DioClientFactory.create(baseUrl);
  }
}
