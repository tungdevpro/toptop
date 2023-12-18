import 'package:dio/dio.dart';
import 'package:domain/common/error_type.dart';
import 'package:domain/common/result.dart';
import 'package:logger/logger.dart';

import '../../datasource/remote/dto/api_response.dart';

typedef ResponseToModelMapper<Data, Model> = Model? Function(Data? data);
typedef EntityToModelMapper<Entity, Model> = Model? Function(Entity? entity);
typedef SaveResult<Data> = Future Function(Data? data);

abstract class BaseRepository {
  final _logger = Logger();

  Future<Result<Model>> safeApiCall<Data, Model>(
    Future<ApiResponse<Data>> call, {
    required ResponseToModelMapper<Data, Model> mapper,
    SaveResult<Data?>? saveResult,
  }) async {
    try {
      final response = await call;
      if (response.isSuccess()) {
        saveResult?.call(response.data);
        return Success(mapper.call(response.data));
      }
      return Error(ErrorType.unknow, response.message ?? "An unknown error");
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
            return Error(ErrorType.slowNetwork, e.name);
          case DioExceptionType.unknown:
            return Error(ErrorType.noNetwork, e.name);
          case DioExceptionType.badResponse:
            return Error(ErrorType.unknow, e.name);
          case DioExceptionType.badCertificate:
            return Error(ErrorType.badCertificate, e.name);
        }
      }
      return Error(ErrorType.unknow, 'An unknown error');
    }
  }
}
