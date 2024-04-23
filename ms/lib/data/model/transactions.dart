import 'package:json_annotation/json_annotation.dart';

part 'transactions.g.dart';

@JsonSerializable()
class Transactions {
  @JsonKey(name: 'categoryName')
  String? categoryName;
  @JsonKey(name: 'amount')
  int? amount;
  @JsonKey(name: 'created')
  int? created;
  @JsonKey(name: 'icon')
  String? icon;
  @JsonKey(name: 'transactionDate')
  int? transactionDate;
  @JsonKey(name: 'transactionType')
  int? transactionType;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'categoryId')
  int? categoryId;

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

  Map<String, dynamic> toJson() => _$TransactionsToJson(this);
}
