import 'package:bloc/bloc.dart';
import 'package:ms/data/source/business/ms_repositoy.dart';

part 'budget_state.dart';

class BudgetCubit extends Cubit<BudgetState> {
  BudgetCubit(this.api) : super(AccountInProgress());
  final MsRepository api;

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