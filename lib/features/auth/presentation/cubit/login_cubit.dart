import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../../domain/usecases/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    try {
      // Simulate async login logic (replace this with real use case call)
      await Future.delayed(const Duration(seconds: 1));

      if (email == 'test@example.com' && password == '123456') {
        emit(LoginSuccess(UserEntity(id: "1", email: email, name: 'Francis')));
      } else {
        emit(LoginError('Invalid credentials'));
      }
    } catch (e) {
      emit(LoginError('Something went wrong'));
    }
  }
}
