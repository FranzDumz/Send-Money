import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/send_money_usecase.dart';
import 'send_money_state.dart';

class SendMoneyCubit extends Cubit<SendMoneyState> {
  final SendMoneyUseCase sendMoneyUseCase;

  SendMoneyCubit(this.sendMoneyUseCase) : super(const SendMoneyState());

  void updateRecipient(String recipient) {
    emit(state.copyWith(recipient: recipient));
  }

  void updateAmount(String amount) {
    emit(state.copyWith(amount: amount));
  }

  Future<void> sendMoney(String senderId) async {
    if (state.recipient.isEmpty || state.amount.isEmpty) {
      emit(state.copyWith(errorMessage: "Recipient and amount are required"));
      return;
    }

    final parsedAmount = double.tryParse(state.amount);
    if (parsedAmount == null || parsedAmount <= 0) {
      emit(state.copyWith(errorMessage: "Enter a valid amount"));
      return;
    }



    emit(state.copyWith(
        isLoading: true, errorMessage: null, successMessage: null));

    try {
      final result = await sendMoneyUseCase(
        senderId: senderId,
        recipientName: state.recipient,
        amount: parsedAmount,
      );

      emit(state.copyWith(isLoading: false, successMessage: result));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
