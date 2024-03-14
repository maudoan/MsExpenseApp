import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 'role')
  final Set? role;

  User({
    this.username,
    this.email,
    this.password,
    this.role
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
