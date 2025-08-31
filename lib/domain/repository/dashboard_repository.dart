import '../entities/user_entity.dart';

abstract class DashboardRepository {
  Future<UserEntity> getUserById(String userId);
}
