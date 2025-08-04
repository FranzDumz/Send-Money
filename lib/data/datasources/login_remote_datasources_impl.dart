

import '../../domain/entities/user_entity.dart';

class LoginRemoteDataSourceImpl {
  Future<UserEntity> login(String email, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    if (email == 'test@example.com' && password == '123456') {
      return UserEntity(id: '1', name: 'Test User', email: email);
    } else {
      throw Exception('Invalid credentials');
    }
  }
}
