import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/user_entity.dart';
import '../../auth/presentation/cubit/session/session_cubit.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashBoardState> {
  final SessionCubit sessionCubit;
  UserEntity? _user;

  DashboardCubit({required this.sessionCubit}) : super(DashBoardInitial());

  UserEntity? get user => _user;

  /// Load user from SessionCubit
  Future<void> loadUserFromSession() async {
    final currentUser = sessionCubit.getCurrentUser();
    if (currentUser != null) {
      _user = currentUser;
      emit(UserRefreshSuccess());
    } else {
      emit(UserRefreshError());
    }
  }

  /// Refresh user data (e.g., from API or storage via sessionCubit)
  Future<void> refreshUserData() async {
    emit(UserRefreshLoading());

    final currentUser =  sessionCubit.getCurrentUser();
    if (currentUser != null) {
      _user = currentUser;
      emit(UserRefreshSuccess());
    } else {
      emit(UserRefreshError());
    }
  }

  /// Set current user (delegates to SessionCubit)
  Future<void> setUser(UserEntity user) async {
    await sessionCubit.saveSession(user);
    _user = user;
    emit(UserRefreshSuccess());
  }

  /// Clear user (delegates to SessionCubit)
  Future<void> clearUser() async {
    await sessionCubit.clearSession();
    _user = null;
    emit(DashBoardInitial());
  }
}
