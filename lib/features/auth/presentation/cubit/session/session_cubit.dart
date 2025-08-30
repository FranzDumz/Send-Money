import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/storage/flutter_secure_storage.dart';
import '../../../../../domain/entities/user_entity.dart';
import 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final SecureStorageService storage;

  SessionCubit(this.storage) : super(SessionInitial());

  ///  Check if a user session exists
  Future<void> checkSession() async {
    final userJson = await storage.read('user');
    if (userJson != null && userJson.isNotEmpty) {
      emit(SessionValid(user: UserEntity.fromJson(jsonDecode(userJson))));
    } else {
      emit(SessionInvalid());
    }
  }

  ///  Save session when user logs in
  Future<void> saveSession(UserEntity user) async {
    await storage.write('user', jsonEncode(user.toJson()));
    emit(SessionValid(user: user));
  }

  ///  Clear session when user logs out
  Future<void> clearSession() async {
    await storage.delete('user');
    emit(SessionInvalid());
  }

  ///  Get current session details (user info)
  UserEntity? getCurrentUser() {
    if (state is SessionValid) {
      return (state as SessionValid).user;
    }
    return null;
  }
}
