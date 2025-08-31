import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/storage/flutter_secure_storage.dart';
import '../../../../../domain/entities/user_entity.dart';
import 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final SecureStorageService storage;

  SessionCubit(this.storage) : super(SessionInitial());

  Future<void> checkSession() async {
    final userJson = await storage.read('user');
    if (userJson != null && userJson.isNotEmpty) {
      emit(SessionValid(user: UserEntity.fromJson(jsonDecode(userJson))));
    } else {
      emit(SessionInvalid());
    }
  }

  Future<void> saveSession(UserEntity user) async {
    await storage.write('user', jsonEncode(user.toJson()));
    emit(SessionValid(user: user));
  }

  /// Clear **everything** in storage and invalidate session
  Future<void> clearSession() async {
    await storage.clear();
    emit(SessionInvalid());
  }

  /// Always get the current user from storage
  Future<UserEntity?> getCurrentUser() async {
    final userJson = await storage.read('user');
    if (userJson != null && userJson.isNotEmpty) {
      return UserEntity.fromJson(jsonDecode(userJson));
    }
    return null;
  }
}
