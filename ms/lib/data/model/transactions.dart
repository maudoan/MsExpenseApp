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
  @JsonKey(name: 'icon')
  final String? icon;
  @JsonKey(name: 'transactionDate')
  final int? transactionDate;
  @JsonKey(name: 'transactionType')
  final int? transactionType;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'categoryId')
  final int? categoryId;

  Transactions(
      {this.categoryName,
      this.amount,
      this.created,
      this.icon,
      this.transactionDate,
      this.transactionType,
      this.description,
      this.categoryId});

  factory Transactions.fromJson(Map<String, dynamic> json) =>
      _$TransactionsFromJson(json);
}
