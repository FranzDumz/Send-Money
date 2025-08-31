

abstract class SendMoneyRepository {
  Future<String> sendMoney({
    required String recipientName,
    required String senderId,
    required double amount,
  });
}

