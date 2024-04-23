import 'package:bloc/bloc.dart';
import 'package:ms/data/source/business/ms_repositoy.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.api) : super(SearchTransactionParentInProgress());
  final MsRepository api;

  Future searchTransactionParent(String query) async {
    try {
      emit(SearchTransactionParentLoading());
      final userInfo =
          await api.searchTransactionParent(query);
      emit(SearchTransactionParentSuccess(response: userInfo));
    } catch (e) {
      emit(SearchTransactionParentFail(error: e));
    }
  }
}
