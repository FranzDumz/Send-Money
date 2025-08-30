import '../models/transaction_model.dart';
import '../../../core/network/api_client.dart';

abstract class TransactionRemoteDataSource {
  Future<List<TransactionModel>> getTransactionsByUserId(String userId);
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final ApiClient _apiClient = ApiClient();

  TransactionRemoteDataSourceImpl();

  @override
  Future<List<TransactionModel>> getTransactionsByUserId(String userId) async {
    final response = await _apiClient.get('users/$userId');
    final data = response.data;

    if (data['transactions'] != null) {
      final transactions = (data['transactions'] as List)
          .map((json) => TransactionModel.fromJson(json))
          .toList();

      // Sort by latest date first
      transactions.sort((a, b) {
        final dateA = DateTime.parse(a.date);
        final dateB = DateTime.parse(b.date);
        return dateB.compareTo(dateA); // descending
      });

      return transactions;
    }

    return [];
  }
}
