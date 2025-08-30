import '../../../../../domain/entities/user_entity.dart';

abstract class SessionState {}

class SessionInitial extends SessionState {}

class SessionValid extends SessionState {
  final UserEntity user;
  SessionValid({required this.user});
}

class SessionInvalid extends SessionState {}
