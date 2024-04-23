import 'package:ms/data/model/transaction_parent.dart';
import 'package:ms/data/model/user.dart';

abstract class MsRepository {
  Future<User?> getCurrentUser();
  Future<List<TransactionParent>> searchTransactionParent(String query);
}