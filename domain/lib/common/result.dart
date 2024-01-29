import 'error_type.dart';

class Result<T> extends SealedResult<T> {
  bool get isSuccessful => this is AppSuccess<T>;
}

class AppSuccess<T> extends Result<T> {
  T? data;

  AppSuccess(this.data);
}

class AppError<T> extends Result<T> {
  ErrorType type;
  String error;

  AppError(this.type, this.error);
}

abstract class SealedResult<T> {
  R? when<R>({
    R Function(T?)? success,
    R Function(ErrorType, String)? error,
  }) {
    if (this is AppSuccess<T?>) {
      return success?.call(((this as AppSuccess).data));
    }
    if (this is AppError<T>) {
      return error?.call((this as AppError<T>).type, (this as AppError<T>).error);
    }
    throw Exception('An error occurred');
  }
}
