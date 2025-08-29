import 'package:equatable/equatable.dart';

class SendMoneyState extends Equatable {
  final String recipient;
  final String amount;
  final bool isLoading;
  final String? successMessage;
  final String? errorMessage;

  const SendMoneyState({
    this.recipient = '',
    this.amount = '',
    this.isLoading = false,
    this.successMessage,
    this.errorMessage,
  });

  SendMoneyState copyWith({
    String? recipient,
    String? amount,
    bool? isLoading,
    String? successMessage,
    String? errorMessage,
  }) {
    return SendMoneyState(
      recipient: recipient ?? this.recipient,
      amount: amount ?? this.amount,
      isLoading: isLoading ?? this.isLoading,
      successMessage: successMessage,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [recipient, amount, isLoading, successMessage, errorMessage];
}
