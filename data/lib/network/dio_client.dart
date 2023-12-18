import 'package:data/common/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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
    _dio = Dio();

    _dio.options = BaseOptions(
      baseUrl: baseUrl ?? Constants.baseUrl,
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

  Future<ApiResponse<T>> get<T>(String url,
      {required ComputeCallback convertJson,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    final dio = getDio();
    try {
      final response = await dio.get(url, queryParameters: queryParameters, options: options, cancelToken: cancelToken, onReceiveProgress: onReceiveProgress);
      final result = await compute(convertJson, response.data);
      return ApiResponse<T>(data: (result as T));
    } catch (e) {
      return ApiResponse(message: e.toString());
    }
  }

  // Future<ApiResponse<T>> post<T>(String url,
  //     {dynamic data,
  //     Map<String, dynamic>? queryParameters,
  //     Options? options,
  //     CancelToken? cancelToken,
  //     ProgressCallback? onSendProgress,
  //     ProgressCallback? onReceiveProgress}) async {
  //   final dio = getDio();
  //   try {
  //     final response = await dio.post(url,
  //         data: data,
  //         queryParameters: queryParameters,
  //         options: options,
  //         cancelToken: cancelToken,
  //         onSendProgress: onSendProgress,
  //         onReceiveProgress: onReceiveProgress);
  //     return ApiResponse(data: response.data);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<ApiResponse<T>> put<T>(
  //   String url, {
  //   dynamic data,
  //   Map<String, dynamic>? queryParameters,
  //   Options? options,
  //   CancelToken? cancelToken,
  //   ProgressCallback? onSendProgress,
  //   ProgressCallback? onReceiveProgress,
  // }) async {
  //   final dio = getDio();
  //   try {
  //     final response = await dio.put(
  //       url,
  //       data: data,
  //       queryParameters: queryParameters,
  //       options: options,
  //       cancelToken: cancelToken,
  //       onSendProgress: onSendProgress,
  //       onReceiveProgress: onReceiveProgress,
  //     );
  //     return ApiResponse(data: response.data);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<ApiResponse<T>> delete<T>(
  //   String url, {
  //   dynamic data,
  //   Map<String, dynamic>? queryParameters,
  //   Options? options,
  //   CancelToken? cancelToken,
  //   ProgressCallback? onSendProgress,
  //   ProgressCallback? onReceiveProgress,
  // }) async {
  //   final dio = getDio();
  //   try {
  //     final response = await dio.delete(
  //       url,
  //       data: data,
  //       queryParameters: queryParameters,
  //       options: options,
  //       cancelToken: cancelToken,
  //     );
  //     return ApiResponse(data: response.data);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
