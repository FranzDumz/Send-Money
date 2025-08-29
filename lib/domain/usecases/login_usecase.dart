import '../entities/user_entity.dart';
import '../repository/auth_repository.dart';

class LoginParams {
  final String username;
  final String password;
  LoginParams({required this.username, required this.password});
}

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserEntity> call(LoginParams params) {
    return repository.login(params.username, params.password);
  }
}
