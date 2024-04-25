import 'package:bloc/bloc.dart';
import 'package:ms/data/model/transactions.dart';
import 'package:ms/data/source/business/ms_repositoy.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.api) : super(SearchTransactionParentInProgress());
  final MsRepository api;

  Future searchTransactionParent(String query) async {
    try {
      emit(SearchTransactionParentLoading());
      final transaction = await api.searchTransactionParent(query);
      emit(SearchTransactionParentSuccess(response: transaction));
    } catch (e) {
      emit(SearchTransactionParentFail(error: e));
    }
  }

  Future createTransaction(Transactions transactions) async {
    try {
      emit(CreateTransactionLoading());
      final transaction = await api.createTransaction(transactions);
      emit(CreateTransactionSuccess(response: transaction));
    } catch (e) {
      emit(CreateTransactionFail(error: e));
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
