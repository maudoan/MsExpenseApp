part of 'budget_cubit.dart';

abstract class BudgetState {
  BudgetState();
}

class AccountInProgress extends BudgetState {}

class AccountLoading extends BudgetState {}

class AccountSuccess extends BudgetState {
  AccountSuccess({this.response});
  final dynamic response;
}

class AccountFail extends BudgetState {
  AccountFail({this.error});
  final dynamic error;
}

class SearchTransactionParentInProgress extends BudgetState {}

class SearchTransactionParentLoading extends BudgetState {}

class SearchTransactionParentSuccess extends BudgetState {
  SearchTransactionParentSuccess({this.response});
  final dynamic response;
}

class SearchTransactionParentFail extends BudgetState {
  SearchTransactionParentFail({this.error});
  final dynamic error;
}