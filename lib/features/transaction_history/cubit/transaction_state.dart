import '../../../domain/entities/transaction_entity.dart';

class TransactionState {
  final bool isLoading;
  final List<TransactionEntity> transactions;
  final String? errorMessage;

  TransactionState({
    this.isLoading = false,
    this.transactions = const [],
    this.errorMessage,
  });

  TransactionState copyWith({
    bool? isLoading,
    List<TransactionEntity>? transactions,
    String? errorMessage,
  }) {
    return TransactionState(
      isLoading: isLoading ?? this.isLoading,
      transactions: transactions ?? this.transactions,
      errorMessage: errorMessage,
    );
  }
}
