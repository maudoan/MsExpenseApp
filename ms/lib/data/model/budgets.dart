import 'package:json_annotation/json_annotation.dart';

part 'budgets.g.dart';

@JsonSerializable()
class Budgets {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'categoryType')
  int? categoryType;
  @JsonKey(name: 'amount')
  int? amount;
  @JsonKey(name: 'created')
  int? created;
  @JsonKey(name: 'categoryName')
  String? categoryName;
  @JsonKey(name: 'budgetDateStart')
  int? budgetDateStart;
  @JsonKey(name: 'budgetBalance')
  int? budgetBalance;
  @JsonKey(name: 'budgetDateEnd')
  int? budgetDateEnd;
  @JsonKey(name: 'categoryIcon')
  String? categoryIcon;
  @JsonKey(name: 'categoryId')
  int? categoryId;

  Budgets(
      {this.id,
      this.categoryName,
      this.amount,
      this.created,
      this.categoryIcon,
      this.budgetDateStart,
      this.budgetDateEnd,
      this.budgetBalance,
      this.categoryType,
      this.categoryId});

  factory Budgets.fromJson(Map<String, dynamic> json) =>
      _$BudgetsFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetsToJson(this);
}
