import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/storage/flutter_secure_storage.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/login_usecase.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashBoardState> {
  final SecureStorageService _storage = SecureStorageService();
  UserEntity? _user;

  DashboardCubit() : super(DashBoardInitial());

  UserEntity? get user => _user;

  /// Load user from secure storage
  Future<void> loadUserFromStorage() async {
    final jsonString = await _storage.read('user');
    if (jsonString != null) {
      try {
        final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        _user = UserEntity.fromJson(jsonMap);
        emit(UserRefreshSuccess());
      } catch (_) {
        emit(UserRefreshError());
      }
    } else {
      emit(DashBoardInitial());
    }
  }

  /// Refresh user data (e.g., balance, points)
  Future<void> refreshUserData() async {
    if (_user == null) {
      emit(UserRefreshError());
      return;
    }

    emit(UserRefreshLoading());

    try {
      // Example: simulate a balance update
      _user = UserEntity(
        id: _user!.id,
        username: _user!.username,
        name: _user!.name,
        password: _user!.password,
        balance: _user!.balance,
        transactions: _user!.transactions,
      );

      // Save updated user to secure storage
      await _storage.write('user', jsonEncode(_user!.toJson()));

      emit(UserRefreshSuccess());
    } catch (_) {
      emit(UserRefreshError());
    }
  }

  /// Set current user (after login)
  Future<void> setUser(UserEntity user) async {
    _user = user;
    await _storage.write('user', jsonEncode(user.toJson()));
    emit(UserRefreshSuccess());
  }

  /// Clear user on logout
  Future<void> clearUser() async {
    _user = null;
    await _storage.delete('user');
    emit(DashBoardInitial());
  }
}
