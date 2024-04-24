part of 'home_cubit.dart';

abstract class HomeState {
  HomeState();
}

class SearchTransactionParentInProgress extends HomeState {}

class SearchTransactionParentLoading extends HomeState {}

class SearchTransactionParentSuccess extends HomeState {
  SearchTransactionParentSuccess({this.response});
  final dynamic response;
}

class SearchTransactionParentFail extends HomeState {
  SearchTransactionParentFail({this.error});
  final dynamic error;
}

class CreateTransactionInProgress extends HomeState {}

class CreateTransactionLoading extends HomeState {}

class CreateTransactionSuccess extends HomeState {
  CreateTransactionSuccess({this.response});
  final dynamic response;
}

class CreateTransactionFail extends HomeState {
  CreateTransactionFail({this.error});
  final dynamic error;
}

class AccountInProgress extends HomeState {}

class AccountLoading extends HomeState {}

class AccountSuccess extends HomeState {
  AccountSuccess({this.response});
  final dynamic response;
}

class AccountFail extends HomeState {
  AccountFail({this.error});
  final dynamic error;
}