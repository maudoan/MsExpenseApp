part of 'login_cubit.dart';

abstract class LoginState {
  LoginState();
}

class LoginInProgress extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  LoginSuccess({this.response});
  final dynamic response;
}

class LoginFail extends LoginState {
  LoginFail({this.error});
  final dynamic error;
}

class AccountInProgress extends LoginState {}

class AccountLoading extends LoginState {}

class AccountSuccess extends LoginState {
  AccountSuccess({this.response});
  final dynamic response;
}

class AccountFail extends LoginState {
  AccountFail({this.error});
  final dynamic error;
}
