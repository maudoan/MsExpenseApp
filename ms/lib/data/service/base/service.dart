import 'package:dio/dio.dart';
import 'package:ms/core/base/base_response.dart';
import 'package:ms/core/network/api_helper.dart';
import 'package:ms/data/model/transaction_parent.dart';
import 'package:ms/data/model/transactions.dart';
import 'package:ms/data/model/user.dart';
import 'package:retrofit/retrofit.dart';

part 'service.g.dart';

@RestApi()
abstract class MsService {
  factory MsService(Dio dio, {String baseUrl}) = _MsService;

  static MsService create() {
    final dio = ApiHelper().createDio()..addInterceptors();

    final client = MsService(dio);
    return client;
  }

  @GET('http://192.168.0.7:8081/api/users/current')
  Future<HttpResponse<BaseResponse<User>>> getCurrentUser();

  @GET('http://192.168.0.7:8081/api/transaction-category-parent/search')
  Future<HttpResponse<List<TransactionParent>>> searchTransactionParent(
      @Query("query") String query);

  @POST('http://192.168.0.7:8081/api/transactions')
  Future<HttpResponse<Transactions>> createTransaction(
      @Body() Transactions transactions);

  @DELETE('http://192.168.0.7:8081/api/transactions/{id}')
  Future<HttpResponse> deleteTransactions(@Path('id') int id);

  @PUT('http://192.168.0.7:8081/api/transactions/{id}')
  Future<HttpResponse<Transactions>> updateTransactions(
      @Path('id') int id, @Body() Transactions transactions);
}
