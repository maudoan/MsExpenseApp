import 'package:ms/data/model/transaction_parent.dart';
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
}
