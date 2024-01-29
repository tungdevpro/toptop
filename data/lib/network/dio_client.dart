import 'package:data/common/constants.dart';
import 'package:dio/dio.dart';
import 'package:environment/environment.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../datasource/remote/dto/api_response.dart';

@singleton
class DioClient {
  late Dio _dio;

  Dio getDio() {
    return _dio;
  }

  Future<void> init({List<InterceptorsWrapper>? interceptors, bool hasLog = true, String? baseUrl}) async {
    _dio = Dio()
      ..options = BaseOptions(
        baseUrl: baseUrl ?? AppEnvironment.apiBaseUrl,
        contentType: NetworkRequestValues.contentType,
        sendTimeout: const Duration(milliseconds: Constants.timeOut),
        connectTimeout: const Duration(milliseconds: Constants.timeOut),
        receiveTimeout: const Duration(milliseconds: Constants.timeOut),
      );

    if (interceptors?.isNotEmpty ?? false) _dio.interceptors.addAll(interceptors!);
    if (hasLog) {
      _dio.interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true, responseBody: true, responseHeader: false, compact: false));
    }
  }

  Future<ApiResponse> get(String url,
      {Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, ProgressCallback? onReceiveProgress}) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return ApiResponse.fromJson(response.data);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse> post(String url,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final response = await _dio.post(url,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
      return ApiResponse(data: response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    // final dio = getDio();
    try {
      final response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return ApiResponse(data: response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return ApiResponse(data: response.data);
    } catch (e) {
      rethrow;
    }
  }
}
