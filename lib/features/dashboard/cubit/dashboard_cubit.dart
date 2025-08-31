import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/dashboard_usecase.dart';
import '../../auth/presentation/cubit/session/session_cubit.dart';
import '../../auth/presentation/cubit/session/session_state.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashBoardState> {
  final SessionCubit sessionCubit;
  final DashBoardUseCase getUserUseCase;
  UserEntity? _user;

  bool _isRefreshing = false;

  DashboardCubit({
    required this.sessionCubit,
    required this.getUserUseCase,
  }) : super(DashBoardInitial()) {
    // Listen for session updates
    sessionCubit.stream.listen((state) {
      if (state is SessionValid) {
        _user = state.user;
        _refreshIfNotRefreshing();
      } else if (state is SessionInvalid) {
        _user = null;
      }
    });

    // Initialize user if session already valid
    if (sessionCubit.state is SessionValid) {
      _user = (sessionCubit.state as SessionValid).user;
      _refreshIfNotRefreshing();
    }
  }

  UserEntity? get user => _user;

  Future<void> refreshUserData({bool updateSession = true}) async {
    if (_user == null) {
      emit(UserRefreshError(errorMessage: 'No user in session'));
      return;
    }

    emit(UserRefreshLoading());
    _isRefreshing = true;

    try {
      final updatedUser = await getUserUseCase(_user!.id);
      _user = updatedUser;

      if (updateSession) {
        await sessionCubit.saveSession(updatedUser);
      }

      emit(UserRefreshSuccess(updatedUser));
    } catch (e) {
      emit(UserRefreshError(errorMessage: e.toString()));
    } finally {
      _isRefreshing = false;
    }
  }

  void _refreshIfNotRefreshing() {
    if (!_isRefreshing) {
      refreshUserData(updateSession: false);
    }
  }
}
