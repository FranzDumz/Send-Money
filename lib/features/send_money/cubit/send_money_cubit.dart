import 'package:flutter_bloc/flutter_bloc.dart';
import 'send_money_state.dart';

class SendMoneyCubit extends Cubit<SendMoneyState> {
  SendMoneyCubit() : super(const SendMoneyState());

  void updateRecipient(String recipient) {
    emit(state.copyWith(recipient: recipient));
  }

  void updateAmount(String amount) {
    emit(state.copyWith(amount: amount));
  }

  Future<void> sendMoney() async {
    if (state.recipient.isEmpty || state.amount.isEmpty) {
      emit(state.copyWith(errorMessage: "Recipient and amount are required"));
      return;
    }

    final parsedAmount = double.tryParse(state.amount);
    if (parsedAmount == null || parsedAmount <= 0) {
      emit(state.copyWith(errorMessage: "Enter a valid amount"));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null, successMessage: null));

    // Simulate network call
    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(
      isLoading: false,
      successMessage: "Sent ₱${parsedAmount.toStringAsFixed(2)} to ${state.recipient}",
    ));
  }
}
