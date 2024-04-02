part of 'account_cubit.dart';

abstract class AccountState {
  AccountState();
}

class AccountInProgress extends AccountState {}

class AccountLoading extends AccountState {}

class AccountSuccess extends AccountState {
  AccountSuccess({this.response});
  final dynamic response;
}

class AccountFail extends AccountState {
  AccountFail({this.error});
  final dynamic error;
}
