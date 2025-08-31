import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/entities/user_entity.dart';
import '../../../../../domain/usecases/login_usecase.dart';
import '../session/session_cubit.dart';

part 'login_state.dart';


class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final SessionCubit sessionCubit;

  LoginCubit(this.loginUseCase, this.sessionCubit) : super(LoginInitial());

  Future<void> login(String username, String password) async {
    try {
      emit(LoginLoading());
      final user = await loginUseCase.call(LoginParams(username: username, password: password));

      await sessionCubit.saveSession(user);

      emit(LoginSuccess(user));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}


