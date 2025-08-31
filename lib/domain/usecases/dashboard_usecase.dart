// domain/usecases/get_user_usecase.dart
import '../entities/user_entity.dart';
import '../repository/dashboard_repository.dart';


class DashBoardUseCase {
  final DashboardRepository repository;

  DashBoardUseCase({required this.repository});

  Future<UserEntity> call(String userId) async {
    return await repository.getUserById(userId);
  }
}
