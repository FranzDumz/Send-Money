// domain/repositories/dashboard_repository.dart
import '../entities/user_entity.dart';

abstract class DashboardRepository {
  Future<UserEntity> getUserById(String userId);
}
