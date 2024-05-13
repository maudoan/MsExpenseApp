import 'package:ms/data/model/budgets.dart';
import 'package:ms/data/model/transaction_parent.dart';
import 'package:ms/data/model/transactions.dart';
import 'package:ms/data/model/user.dart';
import 'package:ms/data/service/base/service.dart';
import 'package:ms/data/source/business/ms_repositoy.dart';

class ServiceApi implements MsRepository {
  final MsService msService;

  ServiceApi({required this.msService});

  @override
  Future<User?> getCurrentUser() {
    final response = msService.getCurrentUser().then(
      (httpResponse) {
        return User.fromJson(httpResponse.response.data);
      },
    );
    return response;
  }

  @override
  Future<List<TransactionParent>> searchTransactionParent(String query) {
    final response = msService.searchTransactionParent(query).then(
      (httpResponse) {
        return httpResponse.data;
      },
    );
    return response;
  }

  @override
  Future<Transactions> createTransaction(Transactions param) {
    final response = msService.createTransaction(param).then(
      (httpResponse) {
        return httpResponse.data;
      },
    );
    return response;
  }

  @override
  Future deleteTransactions(int id) {
    final response = msService.deleteTransactions(id).then(
      (httpResponse) {
        return httpResponse;
      },
    );
    return response;
  }

  @override
  Future<Transactions> updateTransaction(int id, Transactions transactions) {
    final response = msService.updateTransactions(id, transactions).then(
      (httpResponse) {
        return httpResponse.data;
      },
    );
    return response;
  }

  @override
  Future<Budgets> createBudget(Budgets param) {
    final response = msService.createBudget(param).then(
      (httpResponse) {
        return httpResponse.data;
      },
    );
    return response;
  }

  @override
  Future deleteBudget(int id) {
    final response = msService.deleteBudget(id).then(
      (httpResponse) {
        return httpResponse;
      },
    );
    return response;
  }
}
