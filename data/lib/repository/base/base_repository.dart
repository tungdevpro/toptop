import 'package:dio/dio.dart';
import 'package:domain/common/error_type.dart';
import 'package:domain/common/result.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import '../../datasource/remote/dto/api_response.dart';

typedef ResponseToModelMapper<Data, Model> = Model? Function(Data? data);
typedef EntityToModelMapper<Entity, Model> = Model? Function(Entity? entity);
typedef SaveResult<Data> = Future Function(Data? data);

// Nơi bọc wrap repository. Sử dụng (isolate) để parse json sang model để tăng tốc performance
abstract class BaseRepository {
  final _logger = Logger();

  Future<Result<Model>> apiCall<Data, Model>(Future<ApiResponse<Data>> call,
      {required ResponseToModelMapper<Data, Model> mapper, SaveResult<Data?>? saveResult}) async {
    try {
      final response = await call;
      if (response.isSuccess()) {
        saveResult?.call(response.data);
        final result = await compute(mapper, response.data);

        return AppSuccess(result);
      }
      return AppError(ErrorType.unknow, response.error ?? "An unknown error");
    } catch (e) {
      _logger.e("Api error message -> ${e.toString()}");
      _logger.e(e);

      if (e is DioExceptionType) {
        switch (e) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.sendTimeout:
          case DioExceptionType.receiveTimeout:
          case DioExceptionType.cancel:
          case DioExceptionType.connectionError:
            return AppError(ErrorType.slowNetwork, e.name);
          case DioExceptionType.unknown:
            return AppError(ErrorType.noNetwork, e.name);
          case DioExceptionType.badResponse:
            return AppError(ErrorType.unknow, e.name);
          case DioExceptionType.badCertificate:
            return AppError(ErrorType.badCertificate, e.name);
        }
      }
      return AppError(ErrorType.unknow, 'An unknown error');
    }
  }
}
