import 'package:ms/data/model/transaction_parent.dart';
import 'package:ms/data/model/transactions.dart';
import 'package:ms/data/model/user.dart';

abstract class MsRepository {
  Future<User?> getCurrentUser();
  Future<List<TransactionParent>> searchTransactionParent(String query);
  Future<Transactions> createTransaction(Transactions param);
  Future<dynamic>deleteTransactions(int id);
  Future<Transactions> updateTransaction(int id, Transactions transactions);
}