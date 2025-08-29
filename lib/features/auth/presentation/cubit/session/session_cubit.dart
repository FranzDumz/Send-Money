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
      emit(SessionValid());
    } else {
      emit(SessionInvalid());
    }
  }

  Future<void> saveSession(UserEntity user) async {
    await storage.write('user', jsonEncode(user.toJson()));
    emit(SessionValid());
  }

  Future<void> clearSession() async {
    await storage.delete('user');
    emit(SessionInvalid());
  }
}
