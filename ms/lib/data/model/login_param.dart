import 'package:json_annotation/json_annotation.dart';

part 'login_param.g.dart';

@JsonSerializable()
class LoginParam {
  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 'role')
  final Set? role;

  LoginParam({
    this.username,
    this.email,
    this.password,
    this.role
  });

  factory LoginParam.fromJson(Map<String, dynamic> json) => _$LoginParamFromJson(json);
}
