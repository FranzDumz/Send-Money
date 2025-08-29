import '../entities/user_entity.dart';

abstract class SendMoneyRepository {
  Future<UserEntity> login(String username, String password);
}
