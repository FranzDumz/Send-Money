// data/datasources/dashboard_datasource.dart
import '../models/user_model.dart';
import '../../../core/network/api_client.dart';

abstract class DashboardRemoteDataSource {
  Future<UserModel> getUserById(String userId);
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final ApiClient _apiClient = ApiClient();

  DashboardRemoteDataSourceImpl();

  @override
  Future<UserModel> getUserById(String userId) async {
    try {
      final response = await _apiClient.get('users/$userId');
      final data = response.data;

      if (data == null) {
        throw 'User data is null';
      }

      return UserModel.fromJson(data);
    } catch (e) {
      throw 'Failed to fetch user: $e';
    }
  }
}
