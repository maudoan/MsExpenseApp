import 'package:bloc/bloc.dart';
import 'package:ms/data/model/transactions.dart';
import 'package:ms/data/source/business/ms_repositoy.dart';

part 'dashboard_state.dart';

class DashBoardCubit extends Cubit<DashboardState> {
  DashBoardCubit(this.api) : super(DeleteTransactionInProgress());
  final MsRepository api;

  Future deleteTransaction(int id) async {
    try {
      emit(DeleteTransactionLoading());
      final res = await api.deleteTransactions(id);
      emit(DeleteTransactionSuccess(response: res));
    } catch (e) {
      emit(DeleteTransactionFail(error: e));
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

  Future updateTransaction(int? id, Transactions transactions) async {
    try {
      emit(UpdateTransactionLoading());
      final transaction = await api.updateTransaction(id!, transactions);
      emit(UpdateTransactionSuccess(response: transaction));
    } catch (e) {
      emit(UpdateTransactionFail(error: e));
    }
  }

  Future searchTransactionParent(String query) async {
    try {
      emit(SearchTransactionParentLoading());
      final transaction = await api.searchTransactionParent(query);
      emit(SearchTransactionParentSuccess(response: transaction));
    } catch (e) {
      emit(SearchTransactionParentFail(error: e));
    }
  }
}
