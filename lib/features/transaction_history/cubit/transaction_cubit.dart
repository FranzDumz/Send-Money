import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/transaction_usecase.dart';

import 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final GetTransactionsUseCase getTransactionsUseCase;

  TransactionCubit(this.getTransactionsUseCase) : super(TransactionState());

  Future<void> loadTransactions(String userId) async {
    emit(state.copyWith(isLoading: true));

    try {
      final transactions = await getTransactionsUseCase(userId);
      emit(state.copyWith(isLoading: false, transactions: transactions));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
