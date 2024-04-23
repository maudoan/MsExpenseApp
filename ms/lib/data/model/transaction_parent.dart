
import 'package:json_annotation/json_annotation.dart';
import 'package:ms/data/model/transaction_child.dart';

part 'transaction_parent.g.dart';

@JsonSerializable()
class TransactionParent {
  @JsonKey(name: 'created')
  final int? created;
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'transactionType')
  final int? transactionType;
  @JsonKey(name: 'icon')
  final String? icon;
  @JsonKey(name: 'transactionCategoryChild')
  final List<TransactionChild>? transactionCategoryChilds;
  @JsonKey(name: 'userId')
  final int? userId;

  TransactionParent(
      {this.created,
      this.id,
      this.name,
      this.transactionType,
      this.icon,
      this.transactionCategoryChilds,
      this.userId});

  factory TransactionParent.fromJson(Map<String, dynamic> json) => _$TransactionParentFromJson(json);
}
