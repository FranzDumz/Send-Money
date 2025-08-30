import 'dart:developer';
import '../../core/network/api_client.dart';
import '../../domain/entities/user_entity.dart';

class SendMoneyRemoteDataSource {
  final ApiClient _apiClient = ApiClient();

  Future<String> sendMoney({
    required String senderId,
    required String recipientName,
    required double amount,
  }) async {
    try {
      // Fetch sender by ID
      final senderResponse = await _apiClient.get('users/$senderId');
      final sender = UserEntity.fromJson(senderResponse.data);

      // Fetch all users to find recipient
      final usersResponse = await _apiClient.get('users');
      final usersData = usersResponse.data as List<dynamic>;

      final allUsers = usersData
          .map((userJson) => UserEntity.fromJson(userJson))
          .toList();

      final recipient = allUsers.firstWhere(
            (user) => user.username.toLowerCase() == recipientName.toLowerCase(),
        orElse: () => throw "Recipient not found",
      );

      // Check balance
      if (sender.balance < amount) {
        throw "Insufficient funds";
      }

      final now = DateTime.now().toIso8601String();

      // Create sender transaction (debit)
      final senderTransaction = {
        "amount": amount,
        "type": "debit",
        "date": now,
        "counterparty": recipient.username,
      };

      // Create recipient transaction (credit)
      final recipientTransaction = {
        "amount": amount,
        "type": "credit",
        "date": now,
        "counterparty": sender.username,
      };

      // Update balances & transactions
      final updatedSender = sender.copyWith(
        balance: sender.balance - amount,
        transactions: [...sender.transactions, senderTransaction],
      );

      final updatedRecipient = recipient.copyWith(
        balance: recipient.balance + amount,
        transactions: [...recipient.transactions, recipientTransaction],
      );

      // Update both in API
      await _apiClient.put('users/${sender.id}', data: updatedSender.toJson());
      await _apiClient.put('users/${recipient.id}', data: updatedRecipient.toJson());

      return "Successfully sent ₱${amount.toStringAsFixed(2)} to ${recipient.name}";
    } catch (e) {
      log("Send money failed: $e");
      throw "$e";
    }
  }
}
