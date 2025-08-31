import 'package:equatable/equatable.dart';
import '../../../domain/entities/user_entity.dart';

abstract class DashBoardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashBoardInitial extends DashBoardState {}

class UserRefreshLoading extends DashBoardState {}

class UserRefreshSuccess extends DashBoardState {
  final UserEntity user;

  UserRefreshSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class UserRefreshError extends DashBoardState {
  final String? errorMessage;

  UserRefreshError({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
