import '../../../domain/entities/user_entity.dart';

abstract class DashBoardState {}

class DashBoardInitial extends DashBoardState {}

class UserRefreshLoading extends DashBoardState {}

class UserRefreshSuccess extends DashBoardState {
  final UserEntity user;
  UserRefreshSuccess(this.user);
}

class UserRefreshError extends DashBoardState {
  final String? errorMessage;
  UserRefreshError({this.errorMessage});
}
