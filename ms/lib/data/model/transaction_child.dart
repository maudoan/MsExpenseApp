
import 'package:json_annotation/json_annotation.dart';

part 'transaction_child.g.dart';

@JsonSerializable()
class TransactionChild {
  @JsonKey(name: 'created')
  final int? created;
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'transactionCategoryParentId')
  final int? transactionCategoryParentId;
  @JsonKey(name: 'icon')
  final String? icon;

  TransactionChild(
      {this.created,
      this.id,
      this.name,
      this.transactionCategoryParentId,
      this.icon});

  factory TransactionChild.fromJson(Map<String, dynamic> json) => _$TransactionChildFromJson(json);
}
