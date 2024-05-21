part of 'dashboard_cubit.dart';

abstract class DashboardState {
  DashboardState();
}

class DeleteTransactionInProgress extends DashboardState {}

class DeleteTransactionLoading extends DashboardState {}

class DeleteTransactionSuccess extends DashboardState {
  DeleteTransactionSuccess({this.response});
  final dynamic response;
}

class DeleteTransactionFail extends DashboardState {
  DeleteTransactionFail({this.error});
  final dynamic error;
}

class AccountInProgress extends DashboardState {}

class AccountLoading extends DashboardState {}

class AccountSuccess extends DashboardState {
  AccountSuccess({this.response});
  final dynamic response;
}

class AccountFail extends DashboardState {
  AccountFail({this.error});
  final dynamic error;
}

class UpdateTransactionInProgress extends DashboardState {}

class UpdateTransactionLoading extends DashboardState {}

class UpdateTransactionSuccess extends DashboardState {
  UpdateTransactionSuccess({this.response});
  final dynamic response;
}

class UpdateTransactionFail extends DashboardState {
  UpdateTransactionFail({this.error});
  final dynamic error;
}

class SearchTransactionParentInProgress extends DashboardState {}

class SearchTransactionParentLoading extends DashboardState {}

class SearchTransactionParentSuccess extends DashboardState {
  SearchTransactionParentSuccess({this.response});
  final dynamic response;
}

class SearchTransactionParentFail extends DashboardState {
  SearchTransactionParentFail({this.error});
  final dynamic error;
}
