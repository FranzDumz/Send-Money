import '../entities/transaction_entity.dart';
import '../repository/transaction_repository.dart';

class GetTransactionsUseCase {
  final TransactionRepository repository;

  GetTransactionsUseCase({required this.repository});

  Future<List<TransactionEntity>> call(String userId) {
    return repository.getTransactionsByUserId(userId);
  }
}
