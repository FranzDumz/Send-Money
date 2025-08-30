import '../../domain/entities/transaction_entity.dart';
import '../../domain/repository/transaction_repository.dart';
import '../datasources/transaction_datasource.dart';


class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;

  TransactionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<TransactionEntity>> getTransactionsByUserId(String userId) {
    return remoteDataSource.getTransactionsByUserId(userId);
  }
}
