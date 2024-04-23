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
