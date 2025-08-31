// data/repository/dashboard_repository_impl.dart
import '../../domain/entities/user_entity.dart';
import '../../domain/repository/dashboard_repository.dart';
import '../datasources/dashboard_datacource.dart';
import '../models/user_model.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> getUserById(String userId) async {
    final UserModel userModel = await remoteDataSource.getUserById(userId);

    // Return as UserEntity
    return UserEntity(
      id: userModel.id,
      username: userModel.username,
      name: userModel.name,
      balance: userModel.balance,
      transactions: userModel.transactions,
    );
  }
}
