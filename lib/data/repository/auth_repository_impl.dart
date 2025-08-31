

import '../../domain/entities/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/login_datasources.dart';


class LoginRepository implements AuthRepository {
  final LoginRemoteDataSource remoteDataSource;


  LoginRepository(this.remoteDataSource);

  @override
  Future<UserEntity> login(String username, String password) async {
    final user = await remoteDataSource.login(username, password);
    return user;
  }
}
