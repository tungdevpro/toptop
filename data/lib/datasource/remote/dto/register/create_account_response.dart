import 'package:json_annotation/json_annotation.dart';
part 'create_account_response.g.dart';

@JsonSerializable()
class CreateAccountResponse {
  CreateAccountItem? item;

  CreateAccountResponse({
    this.item,
  });

  factory CreateAccountResponse.fromJson(Map<String, dynamic> json) => _$CreateAccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAccountResponseToJson(this);
}

@JsonSerializable()
class CreateAccountItem {
  String? accessToken;
  String? refreshToken;
  int? expireAt;
  String? tokenType;

  CreateAccountItem({
    this.accessToken,
    this.refreshToken,
    this.expireAt,
    this.tokenType,
  });

  factory CreateAccountItem.fromJson(Map<String, dynamic> json) => _$CreateAccountItemFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAccountItemToJson(this);
}
