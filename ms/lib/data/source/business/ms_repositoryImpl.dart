import 'package:ms/data/model/budgets.dart';
import 'package:ms/data/model/transaction_parent.dart';
import 'package:ms/data/model/transactions.dart';
import 'package:ms/data/model/user.dart';
import 'package:ms/data/source/business/ms_repositoy.dart';

class MsRepositoryImpl implements MsRepository {
  const MsRepositoryImpl({required this.api});
  final MsRepository api;
  @override
  Future<User> getCurrentUser() {
    throw UnimplementedError();
  }

  @override
  Future<List<TransactionParent>> searchTransactionParent(String query) {
    throw UnimplementedError();
  }

  @override
  Future<Transactions> createTransaction(Transactions param) {
    throw UnimplementedError();
  }

  @override
  Future deleteTransactions(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Transactions> updateTransaction(int id, Transactions transactions) {
    throw UnimplementedError();
  }

  @override
  Future<Budgets> createBudget(Budgets param) {
    throw UnimplementedError();
  }
}
