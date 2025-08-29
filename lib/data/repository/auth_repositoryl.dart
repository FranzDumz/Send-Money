import 'dart:convert';


import '../../core/storage/flutter_secure_storage.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/login_datasources.dart';

class LoginRepository implements AuthRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepository(this.remoteDataSource);

  @override
  Future<UserEntity> login(String username, String password) async {
    final user = await remoteDataSource.login(username, password);

    // Save user to secure storage
    final storage = SecureStorageService();
    await storage.write('user', jsonEncode({
      'id': user.id,
      'username': user.username,
      'name': user.name,
      'password': user.password,
      'balance': user.balance,
      'transactions': user.transactions,
    }));

    return user;
  }
}
