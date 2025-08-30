import '../../core/network/api_client.dart';
import '../../domain/entities/user_entity.dart';

class LoginRemoteDataSource {
  final ApiClient _apiClient = ApiClient();

  Future<UserEntity> login(String username, String password) async {
    try {
      // Fetch list of users from API
      final response = await _apiClient.get('users');
      final List<dynamic> users = response.data;

      // Safely find the user
      Map<String, dynamic>? matchingUser;
      try {
        matchingUser = users.firstWhere(
              (u) => u['username'] == username && u['password'] == password,
        );
      } catch (_) {
        matchingUser = null;
      }

      if (matchingUser == null) {
        throw Exception('Invalid username or password');
      }

      return UserEntity(
        id: matchingUser['id'].toString(),
        name: matchingUser['name'] ?? '',
        username: matchingUser['username'] ?? '',
        balance: (matchingUser['balance'] ?? 0).toDouble(),
        transactions: (matchingUser['transactions'] as List<dynamic>? ?? [])
            .map((t) => Map<String, dynamic>.from(t as Map))
            .toList(),
      );
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }
}
