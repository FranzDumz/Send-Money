
import '../../domain/entities/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/login_remote_datasources_impl.dart';

class LoginRepositoryImpl implements AuthRepository {
  final LoginRemoteDataSourceImpl remoteDataSource;

  LoginRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity> login(String email, String password) {
    return remoteDataSource.login(email, password);
  }
}
