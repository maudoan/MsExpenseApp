import 'package:json_annotation/json_annotation.dart';

part 'login_param.g.dart';

@JsonSerializable(createFactory: false)
class LoginParam {
  String username;
  String password;


  LoginParam({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$LoginParamToJson(this);

  LoginParam copyWith({
    String? username,
    String? password,
  }) {
    return LoginParam(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}
