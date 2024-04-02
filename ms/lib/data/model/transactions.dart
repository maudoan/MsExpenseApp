import 'package:json_annotation/json_annotation.dart';

part 'transactions.g.dart';

@JsonSerializable()
class Transactions {
  @JsonKey(name: 'categoryName')
  final String? categoryName;
  @JsonKey(name: 'amount')
  final int? amount;
  @JsonKey(name: 'created')
  final int? created;

  Transactions({
    this.categoryName,
    this.amount,
    this.created,
  });

  factory Transactions.fromJson(Map<String, dynamic> json) =>
      _$TransactionsFromJson(json);
}
