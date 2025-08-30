import '../repository/send_money_repository.dart';


class SendMoneyUseCase {
  final SendMoneyRepository repository;

  SendMoneyUseCase(this.repository);

  Future<String> call({
    required String senderId,
    required String recipientName,
    required double amount,
  }) {
    return repository.sendMoney(
      senderId: senderId,
      recipientName: recipientName,
      amount: amount,
    );
  }
}
