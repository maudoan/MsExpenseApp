import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ms/core/local/shared_preferences_manager.dart';
import 'package:ms/data/model/login_param.dart';
import 'package:ms/data/service/business/auth_repository.dart';
import 'package:ms/data/source/business/ms_repositoy.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.api, this.authApi) : super(LoginInProgress());
  final MsRepository api;
  final AuthRepository authApi;
  Future login(LoginParam params) async {
    try {
      emit(LoginLoading());
      final userInfo = await authApi.login(params);
      emit(LoginSuccess(response: userInfo));
      await SharedPrefManager.setJWTToken(value: userInfo["accessToken"]);
    } catch (e) {
      emit(LoginFail(error: e));
    }
  }

  Future getCurrentUser() async {
    try {
      emit(AccountLoading());
      final userInfo = await api.getCurrentUser();
      emit(AccountSuccess(response: userInfo));
    } catch (e) {
      emit(AccountFail(error: e));
    }
  }
}
