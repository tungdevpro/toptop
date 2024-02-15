import 'package:json_annotation/json_annotation.dart';
part 'api_model.g.dart';

enum CodeApiModel { success, parseErr, timeout, tokenExprired, unknowErr }

const _mapApiCode = <CodeApiModel, int>{
  CodeApiModel.success: 200,
  CodeApiModel.parseErr: -1,
  CodeApiModel.timeout: -2,
  CodeApiModel.unknowErr: -99,
  CodeApiModel.tokenExprired: 401,
};

extension ApiCodeExts on CodeApiModel {
  int code() => _mapApiCode[this]!;
}

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class ApiModel<T> {
  final String? code;
  final int? status;
  final String? error;
  final List<String>? codes;
  final T? data;

  ApiModel({this.code, this.error, this.codes, this.status, this.data});

  bool isSuccess() => CodeApiModel.success.code() == status;

  bool isTimeOut() => CodeApiModel.timeout.code() == status;

  bool isTokenExprired() => CodeApiModel.tokenExprired.code() == status;

  factory ApiModel.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) => _$ApiModelFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T) toJsonT) => _$ApiModelToJson<T>(this, toJsonT);
}
