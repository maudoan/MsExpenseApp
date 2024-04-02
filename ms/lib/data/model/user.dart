import 'package:json_annotation/json_annotation.dart';
import 'package:ms/data/model/transactions.dart';

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
  @JsonKey(name: 'totalBalance')
  final int? totalBalance;
  @JsonKey(name: 'transactions')
  final List<Transactions>? transactions;

  User(
      {this.username,
      this.email,
      this.password,
      this.role,
      this.totalBalance,
      this.transactions});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
