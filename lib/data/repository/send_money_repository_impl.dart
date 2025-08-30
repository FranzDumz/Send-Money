import '../../domain/entities/user_entity.dart';
import '../../domain/repository/send_money_repository.dart';
import '../datasources/send_money_datasource.dart';


class SendMoneyRepositoryImpl implements SendMoneyRepository {
  final SendMoneyRemoteDataSource remoteDataSource;

  SendMoneyRepositoryImpl(this.remoteDataSource);

  @override
  Future<String> sendMoney({
    required String senderId,
    required String recipientName,
    required double amount,
  }) async {
    final user = await remoteDataSource.sendMoney(
      senderId: senderId,
      recipientName: recipientName,
      amount: amount,
    );
    return user;
  }
}
