import '../../core/network/api_client.dart';
import '../../domain/entities/user_entity.dart';

class LoginRemoteDataSource {
  final ApiClient _apiClient = ApiClient();

  Future<UserEntity> login(String username, String password) async {
    try {
      // Fetch list of users from API
      final response = await _apiClient.get('users');
      final List<dynamic> users = response.data;


      //Compare users based on the returned list of users
      final matchingUser = users.firstWhere(
            (u) => u['username'] == username && u['password'] == password,
        orElse: () => null,
      );

      if (matchingUser == null) {
        throw 'Invalid username or password';
      }

      return UserEntity(
        id: matchingUser['id'].toString(),
        name: matchingUser['name'] ?? '',
        username: matchingUser['username'] ?? '',
        password: matchingUser['password'] ?? '',
        balance: (matchingUser['balance'] ?? 0).toDouble(),
        transactions: (matchingUser['transactions'] as List<dynamic>? ?? [])
            .map((t) => t.toString())
            .toList(),
      );
    } catch (e) {
      throw e.toString();
    }
  }
}
